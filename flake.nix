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

    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    modeling-app = {
      url = "github:kittycad/modeling-app";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    rust-overlay,
    alejandra,
    modeling-app,
    ...
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    overlays = [rust-overlay.overlays.default];

    mkPkgs = system:
      import nixpkgs {
        inherit system overlays;
      };

    forAllSystems = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = mkPkgs system;
          system = system;
        });
  in {
    homeManagerModules.default = {
      pkgs,
      config,
      lib,
      ...
    }: let
      mkIfExists = path:
        if builtins.pathExists path
        then path
        else pkgs.emptyFile;

      alejandraPkg = alejandra.packages.${pkgs.system}.default;
      # Temporary fix for apple sdks
      rustAnalyzer =
        if pkgs.stdenv.isDarwin
        then pkgs.rust-analyzer
        else pkgs.rust-analyzer-nightly;
      kclLsp = modeling-app.packages.${pkgs.system}.kcl-language-server;
    in {
      home.packages = with pkgs; [
        alejandraPkg
        biome
        clang-tools
        gh
        go
        gofumpt
        gotools
        gopls
        jq
        kclLsp
        luajitPackages.jsregexp
        luajitPackages.luarocks
        mdformat
        nixd
        pyright
        ripgrep
        rustAnalyzer
        ruff
        stylua
        taplo
        tree-sitter
        typescript
        typescript-language-server
        yamlfmt
      ];

      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        package = pkgs.neovim;
      };

      home.file = {
        ".config/nvim/init.lua".source = ./init.lua;

        ".config/nvim/lua" = {
          source = mkIfExists ./lua;
        };
      };
    };

    homeConfigurations = forAllSystems (
      {system, ...}:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          modules = [self.homeManagerModules.default];
        }
    );
  };
}
