# flake.nix
{
  description = "Home Manager module for Jessfraz's Vim configuration (Neovim-ready)";

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
    home-manager,
    fenix,
    alejandra,
    ...
  }: let
    # List supported systems (Linux & Darwin on x86_64 and aarch64)
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    # Helper function to generate attributes for each system
    forAllSystems = f:
      builtins.listToAttrs (map (system: {
          name = system;
          value = f system;
        })
        supportedSystems);

        # Create packages for each system
    mkPackages = system: let
    pkgs = import nixpkgs {
      inherit system;
    };
    unstablePkgs = import unstable {
      inherit system;
    };
    fenixPkgs = fenix.packages.${system};
    alejandraPkg = alejandra.defaultPackage.${system};
  in {
    # Home Manager module defining the Vim/Neovim setup
    homeManagerModules = {
      # "default" module can be imported by Home Manager
      default = {pkgs, ...}: let
        mkIfExists = path:
          if builtins.pathExists path
          then path
          else pkgs.emptyFile;
      in {
        # 1. Install necessary packages in the user environment
        home.packages = with pkgs; [
          # Neovim will be installed via programs.neovim below (so we omit pkgs.neovim here)
          alejandraPkg # Alejandra formatter
          fenixPkg.rust-analyzer # Rust analyzer via Fenix
          go # Go compiler
          gopls # Go language server
          typescript # TypeScript (tsc)
          typescript-language-server # TS LSP
          ripgrep # ripgrep search tool
        ];

        # 2. Neovim program configuration (Home Manager will install Neovim)
        programs.neovim = {
          enable = true;
          defaultEditor = true; # Set $EDITOR to nvim
          viAlias = true; # Provide `vi` as alias to nvim
          vimAlias = true; # Provide `vim` alias to nvim
          # (Neovim will read ~/.config/nvim/init.vim which we set below)
        };

        # 3. Link vim configuration files and directories to home
        home.file = {
          # Main Vim config file -> ~/.vimrc and Neovim init.vim
          ".vimrc".source = ./vimrc;
          ".config/nvim/init.vim".source = ./vimrc;

          # Vim plugin & config directories -> link into both ~/.vim and ~/.config/nvim
          ".vim/autoload".source = mkIfExists ./autoload;
          ".config/nvim/autoload".source = mkIfExists ./autoload;

          ".vim/bundle".source = mkIfExists ./bundle;
          ".config/nvim/bundle".source = mkIfExists ./bundle;

          ".vim/colors".source = mkIfExists ./colors;
          ".config/nvim/colors".source = mkIfExists ./colors;

          ".vim/indent".source = mkIfExists ./indent;
          ".config/nvim/indent".source = mkIfExists ./indent;
        };
      };
    };

    # Optionally, provide ready-to-use Home Manager configurations for all systems (not required if you import the module manually)
    homeConfigurations = forAllSystems (
      system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {inherit system;};
          # (If using NixOS or nix-darwin with Home Manager, provide proper homeDirectory and username)
          modules = [self.homeManagerModules.default];
        }
    );
  };
}
