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
  in {
    # Home Manager module
    homeManagerModules.default = {
      config,
      lib,
      pkgs,
      ...
    }: let
      # Get the appropriate packages based on system
      system = pkgs.stdenv.hostPlatform.system;
      unstablePkgs = import unstable {inherit system;};
      fenixPkgs = fenix.packages.${system};
      alejandraPkg = alejandra.defaultPackage.${system};
    in {
      # Define the module options
      options = {};

      # Module configuration
      config = {
        # Install required packages
        home.packages = with pkgs; [
          alejandraPkg
          fenixPkgs.rust-analyzer
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
        /*
          home.file = {
          # Copy the vimrc file
          ".vimrc".source = ./vimrc;
          ".config/nvim/init.vim".source = ./vimrc;

          # Copy all bundle - this creates a directory with all the contents
          ".vim/bundle".source =
            if builtins.pathExists ./bundle
            then ./bundle
            else null;
          ".config/nvim/bundle".source =
            if builtins.pathExists ./bundle
            then ./bundle
            else null;

          # Copy all autoload
          ".vim/autoload".source =
            if builtins.pathExists ./autoload
            then ./autoload
            else null;
          ".config/nvim/autoload".source =
            if builtins.pathExists ./autoload
            then ./autoload
            else null;

          # Copy all colors
          ".vim/colors".source =
            if builtins.pathExists ./colors
            then ./colors
            else null;
          ".config/nvim/colors".source =
            if builtins.pathExists ./colors
            then ./colors
            else null;

          # Copy all indent
          ".vim/indent".source =
            if builtins.pathExists ./indent
            then ./indent
            else null;
          ".config/nvim/indent".source =
            if builtins.pathExists ./indent
            then ./indent
            else null;
        };
        */
      };
    };

    # Home Manager configuration for each system
    homeConfigurations = forAllSystems (
      system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {inherit system;};
          modules = [self.homeManagerModules.default];
        }
    );
  };
}
