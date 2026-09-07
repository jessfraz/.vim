{
  description = "Home Manager module for jessfraz's Vim configuration (Neovim-ready)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    modeling-app = {
      url = "github:kittycad/modeling-app";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    modeling-app,
    ...
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];

    mkPkgs = system:
      import nixpkgs {
        inherit system;
      };

    forAllSystems = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = mkPkgs system;
          system = system;
        });
    mkEditorPackages = pkgs:
      with pkgs; [
        alejandra
        biome
        clang-tools
        gh
        go
        gofumpt
        gotools
        gopls
        jq
        self.packages.${stdenv.hostPlatform.system}.kcl-language-server
        luajitPackages.jsregexp
        luajitPackages.luarocks
        mdformat
        nixd
        pyright
        ripgrep
        rust-analyzer
        ruff
        stylua
        taplo
        tree-sitter
        typescript
        typescript-language-server
        yamlfmt
      ];
  in {
    homeManagerModules.default = {
      pkgs,
      lib,
      ...
    }: {
      home.packages = mkEditorPackages pkgs;

      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        sideloadInitLua = lib.mkDefault true;
        withPython3 = true;
        withRuby = true;

        package = pkgs.neovim-unwrapped;
      };

      home.file = {
        ".config/nvim/init.lua".source = ./init.lua;

        ".config/nvim/lua" = {
          source = ./lua;
        };
      };
    };

    homeConfigurations = forAllSystems (
      {pkgs, ...}:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            self.homeManagerModules.default
            {
              home.username = "nvim-check";
              home.homeDirectory =
                if pkgs.stdenv.hostPlatform.isDarwin
                then "/Users/nvim-check"
                else "/home/nvim-check";
              home.stateVersion = "26.05";
            }
          ];
        }
    );

    packages = forAllSystems ({
      pkgs,
      system,
    }: {
      kcl-language-server = import ./nix/kcl-language-server.nix {
        inherit pkgs;
        package = modeling-app.packages.${system}.kcl-language-server;
      };
      # Only executable packages belong in the shared binary cache.
      editor-tools = pkgs.buildEnv {
        name = "editor-tools";
        paths = mkEditorPackages pkgs ++ [pkgs.neovim];
      };
    });

    checks = forAllSystems ({
      pkgs,
      system,
    }: {
      home = self.homeConfigurations.${system}.activationPackage;
      source-references =
        pkgs.runCommand "rust-source-references-check" {
          nativeBuildInputs = [pkgs.python3];
        } ''
          cd ${self}
          python -m unittest discover -s tests -p test_source_references.py
          touch "$out"
        '';
      telescope =
        pkgs.runCommand "telescope-search-check" {
          nativeBuildInputs = [pkgs.neovim pkgs.ripgrep];
        } ''
          export HOME="$TMPDIR/home"
          mkdir -p "$HOME"
          cd ${self}
          nvim --headless -u NONE \
            --cmd 'set rtp+=${pkgs.vimPlugins.plenary-nvim}' \
            --cmd 'set rtp+=${pkgs.vimPlugins.telescope-nvim}' \
            -l tests/telescope.lua
          touch "$out"
        '';
      kcl-language-server =
        pkgs.runCommand "kcl-language-server-check" {
          nativeBuildInputs = [pkgs.python3];
        } ''
          python ${./tests/kcl_lsp.py} ${self.packages.${system}.kcl-language-server}/bin/kcl-language-server
          touch "$out"
        '';
    });
  };
}
