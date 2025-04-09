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
    # Home Manager configuration for each system
    homeConfigurations = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};
        unstablePkgs = import unstable {inherit system;};
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
                username = "jessfraz"; # Adapt this if needed
                homeDirectory = homeDir; # Adapt this if needed
                stateVersion = "25.05";

                # Install required packages
                packages = with pkgs; [
                  alejandra.defaultPackage.${system}
                  fenix.packages.${system}.rust-analyzer
                  go
                  gopls
                  typescript
                  typescript-language-server
                  ripgrep
                ];

                # Set up the vim configuration directories and files
                file = {
                  # Copy the vimrc file
                  "${homeDir}/.vimrc".source = ./vimrc;
                  "${homeDir}/.config/nvim/init.vim".source = ./vimrc;

                  # Copy all bundle - this creates a directory with all the contents
                  "${homeDir}/.vim/bundle".source =
                    if builtins.pathExists ./bundle
                    then ./bundle
                    else null;
                  "${homeDir}/.config/nvim/bundle".source =
                    if builtins.pathExists ./bundle
                    then ./bundle
                    else null;

                  # Copy all autoload
                  "${homeDir}/.vim/autoload".source =
                    if builtins.pathExists ./autoload
                    then ./autoload
                    else null;
                  "${homeDir}/.config/nvim/autoload".source =
                    if builtins.pathExists ./autoload
                    then ./autoload
                    else null;

                  # Copy all colors
                  "${homeDir}/.vim/colors".source =
                    if builtins.pathExists ./colors
                    then ./colors
                    else null;
                  "${homeDir}/.config/nvim/colors".source =
                    if builtins.pathExists ./colors
                    then ./colors
                    else null;

                  # Copy all indent
                  "${homeDir}/.vim/indent".source =
                    if builtins.pathExists ./indent
                    then ./indent
                    else null;
                  "${homeDir}/.config/nvim/indent".source =
                    if builtins.pathExists ./indent
                    then ./indent
                    else null;
                };
              };

              # Configure Neovim program
              programs.neovim = {
                enable = true;
                defaultEditor = true;
                viAlias = true;
                vimAlias = true;
              };
            }
          ];
        }
    );
  };
}
