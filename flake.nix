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

      # Get the path to the source bundle directory
      sourceBundleDir = ./bundle;

      # Function to build avante.vim in the source directory
      buildAvanteVim = pkgs.stdenv.mkDerivation {
        name = "avante-vim-built";
        src = ./.;

        buildPhase = ''
          # Create the destination directory if it doesn't exist
          mkdir -p $out/bundle/avante.nvim/build

          # Check if the source directory exists
          if [ -d ./avante.nvim-build ]; then
            # Copy all files from avante.nvim-build to the build directory
            cp -r ./avante.nvim-build/* $out/bundle/avante.nvim/build/
          fi

          # Copy the rest of the bundle directory if it exists
          if [ -d ./bundle ]; then
            cp -r ./bundle/* $out/bundle/
          fi
        '';

        # Skip the default install phase as we handle it in buildPhase
        installPhase = "true";
      };

      # Get the built bundle directory or fall back to the original
      builtBundleDir =
        if builtins.pathExists ./bundle && builtins.pathExists "${./bundle}/avante.nvim"
        then buildAvanteVim
        else mkIfExists ./bundle;
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
          recursive = true;
        };
        ".config/nvim/autoload" = {
          source = mkIfExists ./autoload;
          recursive = true;
        };

        # Use the built bundle directory instead of the original
        ".vim/bundle" = {
          source = builtBundleDir;
          recursive = true;
        };
        ".config/nvim/bundle" = {
          source = builtBundleDir;
          recursive = true;
        };

        ".vim/colors" = {
          source = mkIfExists ./colors;
          recursive = true;
        };
        ".config/nvim/colors" = {
          source = mkIfExists ./colors;
          recursive = true;
        };

        ".vim/indent" = {
          source = mkIfExists ./indent;
          recursive = true;
        };
        ".config/nvim/indent" = {
          source = mkIfExists ./indent;
          recursive = true;
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
