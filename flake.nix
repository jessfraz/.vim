{
  description = "Home Manager module for Jessfraz's Vim configuration (Neovim-ready)";

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
  };

  outputs = {
    self,
    nixpkgs,
    unstable,
    home-manager,
    fenix,
    alejandra,
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
    packages = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      vimWithSubmodules = pkgs.stdenv.mkDerivation {
        name = "vim-config";
        src = ./.;

        nativeBuildInputs = [pkgs.git];

        buildPhase = ''
          echo "Updating submodules..."
          git submodule update --init --recursive
        '';

        installPhase = ''
          mkdir -p $out
          cp -r . $out/
        '';
      };
    });

    homeManagerModules = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
      vimSrc = self.packages.${system}.vimWithSubmodules;

      mkIfExists = path:
        if builtins.pathExists path
        then path
        else pkgs.emptyFile;

      alejandraPkg = alejandra.defaultPackage.${pkgs.system};
      rustAnalyzer = fenix.packages.${pkgs.system}.rust-analyzer;
    in {
      default = {...}: {
        home.packages = with pkgs; [
          alejandraPkg
          rustAnalyzer
          go
          gopls
          typescript
          typescript-language-server
          ripgrep
        ];

        programs.neovim = {
          enable = true;
          defaultEditor = true;
          viAlias = true;
          vimAlias = true;
        };

        home.file = {
          ".vimrc".source = "${vimSrc}/vimrc";
          ".config/nvim/init.vim".source = "${vimSrc}/vimrc";

          ".vim/autoload".source = mkIfExists "${vimSrc}/autoload";
          ".config/nvim/autoload".source = mkIfExists "${vimSrc}/autoload";

          ".vim/bundle".source = mkIfExists "${vimSrc}/bundle";
          ".config/nvim/bundle".source = mkIfExists "${vimSrc}/bundle";

          ".vim/colors".source = mkIfExists "${vimSrc}/colors";
          ".config/nvim/colors".source = mkIfExists "${vimSrc}/colors";

          ".vim/indent".source = mkIfExists "${vimSrc}/indent";
          ".config/nvim/indent".source = mkIfExists "${vimSrc}/indent";
        };
      };
    });

    homeConfigurations = forAllSystems (
      system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {inherit system;};
          modules = [(self.homeManagerModules.${system}.default)];
        }
    );
  };
}
