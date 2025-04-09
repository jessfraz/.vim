# flake.nix
{
  description = "Home Manager module for Jessfraz's Vim configuration (Neovim-ready)";

  inputs = {
    # Nixpkgs (stable or follow an unstable channel as needed)
    nixpkgs.url = "github:nixos/nixpkgs";
    # Optionally use unstable for latest packages:
    # unstable.url = "nixpkgs/nixos-unstable";

    # Home Manager for user-level configuration management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      # If using unstable: inputs.nixpkgs.follows = "unstable";
    };

    # Fenix provides nightly Rust toolchains and rust-analyzer&#8203;:contentReference[oaicite:5]{index=5}
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Alejandra (code formatter) flake for package
    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
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
    # List supported systems (Linux & Darwin on x86_64 and aarch64)&#8203;:contentReference[oaicite:6]{index=6}
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    # Helper to apply a function to all supported systems, producing an attrset
    forAllSystems = f:
      builtins.listToAttrs (
        map (system: {
          name = system;
          value = f system;
        })
        supportedSystems
      );
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
          alejandra.defaultPackage.${pkgs.stdenv.hostPlatform.system} # Alejandra formatter&#8203;:contentReference[oaicite:8]{index=8}
          fenix.packages.${pkgs.stdenv.hostPlatform.system}.rust-analyzer # Rust analyzer via Fenix&#8203;:contentReference[oaicite:9]{index=9}
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
