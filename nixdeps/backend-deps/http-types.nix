let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    http-types-pinned-github = initialPkgs.pkgs.lib.importJSON ./http-types.json;
    http-types = initialPkgs.pkgs.fetchFromGitHub {
      owner = "aristidb";
      repo  = "http-types";
      inherit (http-types-pinned-github) rev sha256;
    };
  };
in
  sources.http-types