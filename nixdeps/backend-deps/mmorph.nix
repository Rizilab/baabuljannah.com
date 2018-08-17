let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    mmorph-pinned-github = initialPkgs.pkgs.lib.importJSON ./mmorph.json;
    mmorph = initialPkgs.pkgs.fetchFromGitHub {
      owner = "Gabriel439";
      repo  = "Haskell-MMorph-Library";
      inherit (mmorph-pinned-github) rev sha256;
    };
  };
in
  sources.mmorph