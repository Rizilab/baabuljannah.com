let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    aeson-compat-pinned-github = initialPkgs.pkgs.lib.importJSON ./aeson-compat.json;
    aeson-compat = initialPkgs.pkgs.fetchFromGitHub {
      owner = "phadej";
      repo  = "aeson-compat";
      inherit (aeson-compat-pinned-github) rev sha256;
    };
  };
in
  sources.aeson-compat