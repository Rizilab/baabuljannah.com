let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    http-api-data-pinned-github = initialPkgs.pkgs.lib.importJSON ./http-api-data.json;
    http-api-data = initialPkgs.pkgs.fetchFromGitHub {
      owner = "fizruk";
      repo  = "http-api-data";
      inherit (http-api-data-pinned-github) rev sha256;
    };
  };
in
  sources.http-api-data