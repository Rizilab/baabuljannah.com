let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    lens-pinned-github = initialPkgs.pkgs.lib.importJSON ./lens.json;
    lens = initialPkgs.pkgs.fetchFromGitHub {
      owner = "ekmett";
      repo  = "lens";
      inherit (lens-pinned-github) rev sha256;
    };
  };
in
  sources.lens