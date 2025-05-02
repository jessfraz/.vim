{
  description = "Home Manager module for jessfraz's Vim configuration (Neovim-ready)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
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
    fenix,
    alejandra,
    modeling-app,
    ...
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    forAllSystems = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
          };
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
      rustAnalyzer = fenix.packages.${pkgs.system}.rust-analyzer;
      rustFmt = fenix.packages.${pkgs.system}.rustfmt;
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
        mdformat
        nixd
        pyright
        ripgrep
        rustAnalyzer
        rustFmt
        ruff
        stylua
        typescript
        typescript-language-server
        yamlfmt
      ];

      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        # use the neovim-nightly package
        package = pkgs.neovim-nightly;
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
          pkgs = import nixpkgs {inherit system;};
          modules = [self.homeManagerModules.default];
        }
    );
  };
}
