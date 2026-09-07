"""Exercise the packaged KCL language server over its real stdio protocol."""

import asyncio
import json
import sys


async def check(executable: str) -> None:
    process = await asyncio.create_subprocess_exec(
        executable,
        "server",
        "--stdio",
        stdin=asyncio.subprocess.PIPE,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE,
        env={"PATH": ""},
    )
    assert process.stdin is not None
    assert process.stdout is not None

    async def send(message: dict[str, object]) -> None:
        payload = json.dumps({"jsonrpc": "2.0", **message}).encode()
        assert process.stdin is not None
        process.stdin.write(
            f"Content-Length: {len(payload)}\r\n\r\n".encode() + payload
        )
        await process.stdin.drain()

    async def response(request_id: int) -> dict[str, object]:
        assert process.stdout is not None
        while True:
            header = await process.stdout.readuntil(b"\r\n\r\n")
            length = next(
                int(line.split(b":", 1)[1])
                # Upstream tracing writes LF-delimited logs before some headers.
                for line in header.splitlines()
                if line.lower().startswith(b"content-length:")
            )
            message: dict[str, object] = json.loads(
                await process.stdout.readexactly(length)
            )
            if message.get("id") == request_id:
                assert "error" not in message, message
                return message

    try:
        await send(
            {
                "id": 1,
                "method": "initialize",
                "params": {"processId": None, "rootUri": None, "capabilities": {}},
            }
        )
        initialized = await response(1)
        result = initialized.get("result")
        assert isinstance(result, dict) and "capabilities" in result, initialized
        await send({"method": "initialized", "params": {}})
        await send({"id": 2, "method": "shutdown"})
        shutdown = await response(2)
        assert "result" in shutdown and shutdown["result"] is None, shutdown
        await send({"method": "exit"})
        process.stdin.close()
        # Upstream's signal listener can outlive the LSP session. The shutdown
        # response above is the protocol assertion; terminate the host afterward.
        if process.returncode is None:
            process.terminate()
        assert await process.wait() == 0
    finally:
        if process.returncode is None:
            process.kill()
            await process.wait()


if __name__ == "__main__":
    asyncio.run(asyncio.wait_for(check(sys.argv[1]), timeout=30))
    print("KCL initialized and shut down without tools on PATH")
