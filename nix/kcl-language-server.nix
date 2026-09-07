{
  pkgs,
  package,
}: let
  checkSourceReferences = pkgs.writeText "check-rust-source-references.py" (
    builtins.readFile ./check_source_references.py
  );
  toolchains = pkgs.lib.unique (
    builtins.filter
    (input: pkgs.lib.hasPrefix "rust-default-" (input.name or ""))
    package.nativeBuildInputs
  );
in
  assert builtins.length toolchains == 1;
    package.overrideAttrs (previous: {
      nativeBuildInputs = previous.nativeBuildInputs ++ [pkgs.python3 pkgs.removeReferencesTo];
      # Rust embeds standard-library source locations in the executable. They
      # retain the compiler and its docs despite not being runtime dependencies.
      # Run after stripping linker/debug records. removeReferencesTo re-signs
      # Darwin executables after patching them.
      postFixup =
        (previous.postFixup or "")
        + ''
          python ${checkSourceReferences} "$out/bin/kcl-language-server" ${builtins.head toolchains}
          remove-references-to -t ${builtins.head toolchains} "$out/bin/kcl-language-server"
        '';
      disallowedReferences = (previous.disallowedReferences or []) ++ toolchains;
    })
