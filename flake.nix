{
  description = "Neovim configured for jessfraz";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };

    # rust, see https://github.com/nix-community/fenix#usage
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "unstable";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
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
  }: let
    # Define supported systems
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    # Helper function to generate attributes for each system
    forAllSystems = f:
      builtins.listToAttrs (map (system: {
          name = system;
          value = f system;
        })
        supportedSystems);

    # Helper function for conditional file paths
    mkNeovimModule = pkgs: let
      system = pkgs.stdenv.hostPlatform.system;

      # Helper function to create path only if source exists
      ifExists = path:
        if builtins.pathExists path
        then path
        else pkgs.emptyFile; # Use a valid empty file instead of null
    in {
      home.packages = with pkgs; [
        alejandra.defaultPackage.${system}
        fenix.packages.${system}.rust-analyzer
        go
        gopls
        typescript
        typescript-language-server
        ripgrep
      ];

      # Configure Neovim program
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };

      # Set up the vim configuration directories and files
      home.file = {
        # Copy the vimrc file
        ".vimrc".source = ./vimrc;
        ".config/nvim/init.vim".source = ./vimrc;

        # Copy all bundle - this creates a directory with all the contents
        ".vim/bundle".source = ifExists ./bundle;
        ".config/nvim/bundle".source = ifExists ./bundle;

        # Copy all autoload
        ".vim/autoload".source = ifExists ./autoload;
        ".config/nvim/autoload".source = ifExists ./autoload;

        # Copy all colors
        ".vim/colors".source = ifExists ./colors;
        ".config/nvim/colors".source = ifExists ./colors;

        # Copy all indent
        ".vim/indent".source = ifExists ./indent;
        ".config/nvim/indent".source = ifExists ./indent;
      };
    };
  in {
    # Add the homeManagerModules output
    homeManagerModules = {
      default = {pkgs, ...}: mkNeovimModule pkgs;
    };

    # Home Manager configuration for each system
    homeConfigurations = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};
        unstablePkgs = import unstable {inherit system;};

        # Determine home directory based on OS
        homeDir =
          if pkgs.stdenv.isLinux
          then "/home/jessfraz"
          else "/Users/jessfraz";
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            {
              home = {
                username = "jessfraz";
                homeDirectory = homeDir;
                stateVersion = "25.05";
              };
            }

            # Use the same Neovim module
            (mkNeovimModule pkgs)
          ];
        }
    );
  };
}
