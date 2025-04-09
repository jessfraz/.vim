{
  description = "Neovim configured for jessfraz";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    unstable.url = "nixpkgs/nixos-unstable";

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

    # Package definition function
    packageFor = system: let
      pkgs = import nixpkgs {inherit system;};
      unstablePkgs = import unstable {inherit system;};

      fenixPkgs = fenix.packages.${system};
      alejandraPkg = alejandra.defaultPackage.${system};

      # Define the packages we want to include
      neovim-jessfraz = pkgs.symlinkJoin {
        name = "neovim-jessfraz";
        paths = with pkgs; [
          alejandraPkg
          fenixPkgs.rust-analyzer
          go
          gopls
          neovim
          typescript
          typescript-language-server
          ripgrep
        ];

        postBuild = ''
        '';
      };
    in
      neovim-jessfraz;
  in {
    # Packages for each system
    packages = forAllSystems (system: {
      default = packageFor system;
      neovim-jessfraz = packageFor system;
    });

    # Apps for each system
    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/nvim";
      };
    });

    # Development shells for each system
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      default = pkgs.mkShell {
        packages = [self.packages.${system}.default];
      };
    });
  };
}
