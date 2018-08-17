let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    comonad-pinned-github = initialPkgs.pkgs.lib.importJSON ./comonad.json;
    comonad = initialPkgs.pkgs.fetchFromGitHub {
      owner = "ekmett";
      repo  = "comonad";
      inherit (comonad-pinned-github) rev sha256;
    };
  };
in
  sources.comonad