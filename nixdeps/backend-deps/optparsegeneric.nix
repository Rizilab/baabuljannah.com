let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    optparsegeneric-pinned-github = initialPkgs.pkgs.lib.importJSON ./optparsegeneric.json;
    optparsegeneric = initialPkgs.pkgs.fetchFromGitHub {
      owner = "Gabriel439";
      repo  = "Haskell-Optparse-Generic-Library";
      inherit (optparsegeneric-pinned-github) rev sha256;
    };
  };
in
  sources.optparsegeneric