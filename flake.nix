{
  description = "Home Manager module for jessfraz's Vim configuration (Neovim-ready)";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    modeling-app = {
      url = "github:kittycad/modeling-app";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    selfClone = {
      url = "git+https://github.com/jessfraz/.vim?submodules=1";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
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
          # We want to rename all the libs in $out/lib/libavante* to avante*
          # and move them to $out/bundle/avante.nvim/build
          for lib in $out/lib/libavante*; do
            mv $lib $out/bundle/avante.nvim/build/$(basename $lib | sed 's/^lib//');
          done
        '';

        buildInputs = [pkgs.openssl pkgs.pkg-config pkgs.perl];
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

      avanteNvimLib = self.packages.${pkgs.system}.avante-nvim-lib;
      builtBundle = avanteNvimLib + "/bundle";
    in {
      home.packages = with pkgs; [
        alejandraPkg
        avanteNvimLib
        clang-tools
        gh
        go
        gopls
        kclLsp
        nixd
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
          source = "${self.packages.${pkgs.system}.avante-nvim-lib}/bundle";
        };
        ".config/nvim/bundle" = {
          source = "${self.packages.${pkgs.system}.avante-nvim-lib}/bundle";
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
