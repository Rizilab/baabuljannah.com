let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    aeson-pinned-github = initialPkgs.pkgs.lib.importJSON ./aeson.json;
    aeson = initialPkgs.pkgs.fetchFromGitHub {
      owner = "bos";
      repo  = "aeson";
      inherit (aeson-pinned-github) rev sha256;
    };
  };
in
  sources.aeson