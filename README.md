.vim
====

My vim dot files. 

The flake supports `x86_64-linux`, `aarch64-linux`, and `aarch64-darwin`.
Current nixpkgs no longer supports `x86_64-darwin`.

`nix flake check` builds a standalone Home Manager fixture and runs real
Telescope search and KCL language-server checks. CI builds these checks on
Linux and Apple silicon, using the shared binary cache for downloads.
`packages.<system>.editor-tools` contains only executable packages suitable
for caching, without Home Manager activation files or user configuration.

## Shortcuts

- `Ctrl-P`: Find files
- `Ctrl-G`: Live grep
- `Ctrl-B`: Search git branches
- `Ctrl-A`: Toggle the file sidebar
- `Ctrl-R`: Refresh the file sidebar
- `Ctrl-N`: Multiple cursor support
- `Ctrl-X`: Switch to the next buffer
- `Ctrl-Z`: Switch to the previous buffer
- `Ctrl-T`: Open a floating terminal
- `<Space>`: Center the screen to the cursor

There's a lot more if you hit `,` you can peruse all the ones connected to the leader `,`
