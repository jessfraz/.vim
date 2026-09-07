"""Reject toolchain references that are not Rust source locations."""

import re
import sys
from pathlib import Path


def check(binary: Path, toolchain: str) -> None:
    reference = toolchain.encode()
    contents = binary.read_bytes()
    paths = re.findall(re.escape(reference) + rb"[^\x00\s]*", contents)
    for path in paths:
        if not (
            path.startswith(reference + b"/lib/rustlib/src/rust/library/")
            and path.endswith(b".rs")
        ):
            raise ValueError(
                f"Refusing to remove a possible runtime dependency: {path!r}"
            )


if __name__ == "__main__":
    check(Path(sys.argv[1]), sys.argv[2])
