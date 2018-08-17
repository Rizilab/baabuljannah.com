let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    lens-aeson-pinned-github = initialPkgs.pkgs.lib.importJSON ./lens-aeson.json;
    lens-aeson = initialPkgs.pkgs.fetchFromGitHub {
      owner = "lens";
      repo  = "lens-aeson";
      inherit (lens-aeson-pinned-github) rev sha256;
    };
  };
in
  sources.lens-aeson