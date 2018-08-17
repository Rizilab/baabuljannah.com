let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    cabal-pinned-github = initialPkgs.pkgs.lib.importJSON ./cabal.json;
    cabal = initialPkgs.pkgs.fetchFromGitHub {
      owner = "haskell";
      repo  = "cabal";
      inherit (cabal-pinned-github) rev sha256;
    };
  };
in
  sources.cabal