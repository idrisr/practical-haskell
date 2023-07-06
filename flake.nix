{
  description = "my project description";
  inputs.nixpkgs.url = "nixpkgs";
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      compiler = "ghc928";
      pkgs = import nixpkgs { inherit system; };
      hPkgs = pkgs.haskell.packages."${compiler}";
      myDevTools = with hPkgs; [
        ghc
        ghcid
        fourmolu
        hlint
        hoogle
        haskell-language-server
        implicit-hie
        retrie
        cabal-install
        cabal2nix
        pkgs.zlib
      ];
      app1 = pkgs.haskell.packages.${compiler}.callPackage ./02/cabal.nix;
    in {
      apps.${system} = rec {
        dapp1 = {
          type = "app";
          program = "${app1 { }}/bin/ack";
        };
        default = dapp1;
      };
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = myDevTools;
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath myDevTools;
      };
      packages.${system} = rec {
        dapp1 = app1 { };
        default = dapp1;
      };
    };
}
