let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    base-compat-pinned-github = initialPkgs.pkgs.lib.importJSON ./base-compat.json;
    base-compat = initialPkgs.pkgs.fetchFromGitHub {
      owner = "haskell-compat";
      repo  = "base-compat";
      inherit (base-compat-pinned-github) rev sha256;
    };
  };
in
  sources.base-compat