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
        src = ./bundle;

        # No specific build inputs needed beyond the default
        buildInputs = with pkgs; [
          gnumake
        ];

        # Use a temporary directory for the build
        buildPhase = ''
          if [ -d "./avante.nvim" ]; then
            # Create a temporary writable directory for the build process
            buildDir=$(mktemp -d)
            cp -r ./avante.nvim/* $buildDir/

            # Build in the temporary directory
            cd $buildDir
            ${pkgs.gnumake}/bin/make

            # Create the output directory and copy the built files back
            mkdir -p $out/avante.nvim
            cp -r ./* $out/avante.nvim/
          fi
        '';

        # Copy all other bundle files that weren't built
        installPhase = ''
          # Copy everything except avante.nvim to the output
          for item in $(ls -A ${./bundle}); do
            if [ "$item" != "avante.nvim" ]; then
              mkdir -p $out/$item
              cp -r ${./bundle}/$item/* $out/$item/
            fi
          done

          # If we didn't build avante.nvim in the build phase, copy it directly
          if [ ! -d "$out/avante.nvim" ] && [ -d "${./bundle}/avante.nvim" ]; then
            mkdir -p $out/avante.nvim
            cp -r ${./bundle}/avante.nvim/* $out/avante.nvim/
          fi
        '';
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

        # Build tools
        curl
        git
        gnumake
        gnutar
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
