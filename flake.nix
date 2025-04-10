{
  description = "Home Manager module for jessfraz's Vim configuration (Neovim-ready)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "unstable";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "unstable";
    };

    modeling-app = {
      url = "github:kittycad/modeling-app?ref=repetitive-structs";
      inputs.nixpkgs.follows = "unstable";
    };
  };

  outputs = {
    self,
    nixpkgs,
    unstable,
    home-manager,
    fenix,
    alejandra,
    modeling-app,
    ...
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    forAllSystems = f:
      builtins.listToAttrs (map (system: {
          name = system;
          value = f system;
        })
        supportedSystems);
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

      alejandraPkg = alejandra.defaultPackage.${pkgs.system};
      rustAnalyzer = fenix.packages.${pkgs.system}.rust-analyzer;
      kclLsp = modeling-app.packages.${pkgs.system}.kcl-language-server;

      # Create a custom bundle directory with avante.nvim build files in place
      bundleWithAvanteBuild = pkgs.runCommand "vim-bundle-with-avante-build" {} ''
        mkdir -p $out

        # Copy the original bundle directory if it exists
        if [ -e ${./bundle} ]; then
          cp -r ${./bundle}/* $out/
        fi

        # Create avante.nvim/build directory and copy build files if they exist
        if [ -e ${./avante.nvim-build} ]; then
          mkdir -p $out/avante.nvim
          cp -r ${./avante.nvim-build}/* $out/avante.nvim/build/
        fi
      '';
    in {
      home.packages = with pkgs; [
        alejandraPkg
        clang-tools
        gh
        go
        gopls
        kclLsp
        typescript
        typescript-language-server
        ripgrep
        rustAnalyzer
      ];

      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };

      home.file = {
        ".vimrc".source = ./vimrc;
        ".config/nvim/init.vim".source = ./vimrc;

        ".vim/autoload" = {
          source = mkIfExists ./autoload;
        };
        ".config/nvim/autoload" = {
          source = mkIfExists ./autoload;
        };

        ".vim/bundle" = {
          source = bundleWithAvanteBuild;
        };
        ".config/nvim/bundle" = {
          source = bundleWithAvanteBuild;
        };
        ".vim/colors" = {
          source = mkIfExists ./colors;
        };
        ".config/nvim/colors" = {
          source = mkIfExists ./colors;
        };

        ".vim/indent" = {
          source = mkIfExists ./indent;
        };
        ".config/nvim/indent" = {
          source = mkIfExists ./indent;
        };
      };
    };

    # Optional: Provide buildable homeConfigurations for testing
    homeConfigurations = forAllSystems (
      system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {inherit system;};
          modules = [self.homeManagerModules.default];
        }
    );
  };
}
