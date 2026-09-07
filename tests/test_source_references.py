"""Cover Rust source-file and ELF source-directory references."""

import tempfile
import unittest
from pathlib import Path

from nix.check_source_references import check


class SourceReferencesTests(unittest.TestCase):
    def setUp(self) -> None:
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.binary = self.root / "kcl-language-server"
        self.toolchain = self.root / "rust-default-1.96.0"
        self.sources = self.toolchain / "lib/rustlib/src/rust/library"
        self.sources.mkdir(parents=True)

    def write_reference(self, path: Path) -> None:
        self.binary.write_bytes(str(path).encode() + b"\x00")

    def test_source_files_are_allowed(self) -> None:
        self.write_reference(self.sources / "core/src/future/ready.rs")
        check(self.binary, str(self.toolchain))

    def test_elf_source_directories_are_allowed(self) -> None:
        # The Linux build's DWARF table names this directory without a .rs suffix.
        directory = self.sources / "core/src/convert"
        directory.mkdir(parents=True)
        for path in (directory, self.sources):
            with self.subTest(path=path):
                self.write_reference(path)
                check(self.binary, str(self.toolchain))

    def test_runtime_and_outside_paths_are_rejected(self) -> None:
        paths = (
            self.toolchain / "bin/rustc",
            self.toolchain / "lib/libstd.so",
            self.toolchain / "lib/libstd.dylib",
            self.toolchain / "lib/rustlib/src/rust/library-extra/file.rs",
            self.sources / "../../../../../../bin/rustc.rs",
            self.sources / "core/src/convert/missing-directory",
        )
        for path in paths:
            with self.subTest(path=path):
                self.write_reference(path)
                with self.assertRaises(ValueError):
                    check(self.binary, str(self.toolchain))


if __name__ == "__main__":
    unittest.main()
