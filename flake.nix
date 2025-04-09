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
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            {
              home = {
                username = "jessfraz"; # Adapt this if needed
                homeDirectory = "/Users/jessfraz"; # Adapt this if needed
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
                  "${homeDirectory}/.vimrc".source = ./vimrc;
                  "${homeDirectory}/.config/nvim/init.vim".source = ./vimrc;

                  # Copy all bundle - this creates a directory with all the contents
                  "${homeDirectory}/.vim/bundle".source =
                    if builtins.pathExists ./bundle
                    then ./bundle
                    else null;
                  "${homeDirectory}/.config/nvim/bundle".source =
                    if builtins.pathExists ./bundle
                    then ./bundle
                    else null;

                  # Copy all autoload
                  "${homeDirectory}/.vim/autoload".source =
                    if builtins.pathExists ./autoload
                    then ./autoload
                    else null;
                  "${homeDirectory}/.config/nvim/autoload".source =
                    if builtins.pathExists ./autoload
                    then ./autoload
                    else null;

                  # Copy all colors
                  "${homeDirectory}/.vim/colors".source =
                    if builtins.pathExists ./colors
                    then ./colors
                    else null;
                  "${homeDirectory}/.config/nvim/colors".source =
                    if builtins.pathExists ./colors
                    then ./colors
                    else null;

                  # Copy all indent
                  "${homeDirectory}/.vim/indent".source =
                    if builtins.pathExists ./indent
                    then ./indent
                    else null;
                  "${homeDirectory}/.config/nvim/indent".source =
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
