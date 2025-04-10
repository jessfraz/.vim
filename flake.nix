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

    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "unstable";
    };

    selfClone = {
      url = "git+https://github.com/jessfraz/.vim?submodules=1";
      flake = false;
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
    naersk,
    selfClone,
    ...
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    forAllSystems = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
          };
          system = system;
        });
  in {
    packages = forAllSystems ({
      pkgs,
      system,
      ...
    }: let
      fenixPkgs = fenix.packages.${pkgs.system};
      rustToolchain = fenixPkgs.stable.withComponents [
        "cargo"
        "rustc"
      ];
      naersk-lib = pkgs.callPackage naersk {
        cargo = rustToolchain;
        rustc = rustToolchain;
      };
    in {
      avante-nvim-lib = naersk-lib.buildPackage {
        pname = "avante-nvim-lib";
        version = "0.1.0";
        release = true;

        src = selfClone + /bundle/avante.nvim;
        copyLibs = true;
        copyBins = false;

        cargoBuildOptions = opt: opt ++ ["--all" "--features=luajit"];

        # We want to copy all the source bundle files to the output.
        # AND we want to mv lib/* to bundle/avante.nvim/build
        postInstall = ''
          mkdir -p $out/bundle/avante.nvim
          cp -r ${selfClone}/bundle/* $out/bundle/
          mkdir -p $out/bundle/avante.nvim/build
          mv $out/lib/* $out/bundle/avante.nvim/build/
        '';
      };
      default = self.packages.${system}.avante-nvim-lib;
    });

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

      builtBundle = self.packages.${pkgs.system}.avante-nvim-lib + "/bundle";
    in {
      home.packages = with pkgs; [
        alejandraPkg
        self.packages.${pkgs.system}.avante-nvim-lib
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
        };
        ".config/nvim/autoload" = {
          source = mkIfExists ./autoload;
        };

        ".vim/bundle" = {
          source = builtBundle;
        };
        ".config/nvim/bundle" = {
          source = builtBundle;
        };

        ".vim/colors" = {
          source = mkIfExists ./colors;
        };
        ".config/nvim/colors" = {
          source = mkIfExists ./colors;
        };

        ".vim/indent" = {
          source = mkIfExists ./indent;
        };
        ".config/nvim/indent" = {
          source = mkIfExists ./indent;
        };
      };
    };

    homeConfigurations = forAllSystems (
      {system, ...}:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {inherit system;};
          modules = [self.homeManagerModules.default];
        }
    );
  };
}
