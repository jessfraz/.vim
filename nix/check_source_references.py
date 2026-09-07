"""Reject toolchain references that are not Rust source locations."""

import os
import re
import sys
from pathlib import Path


def check(binary: Path, toolchain: str) -> None:
    reference = toolchain.encode()
    source_root = Path(toolchain) / "lib/rustlib/src/rust/library"
    contents = binary.read_bytes()
    paths = re.findall(re.escape(reference) + rb"[^\x00\s]*", contents)
    for path in paths:
        source_path = Path(os.fsdecode(path))
        if not (
            source_path.is_relative_to(source_root)
            and ".." not in source_path.parts
            # ELF debug information also names source directories without .rs.
            and (source_path.suffix == ".rs" or source_path.is_dir())
        ):
            raise ValueError(
                f"Refusing to remove a possible runtime dependency: {path!r}"
            )


if __name__ == "__main__":
    check(Path(sys.argv[1]), sys.argv[2])
