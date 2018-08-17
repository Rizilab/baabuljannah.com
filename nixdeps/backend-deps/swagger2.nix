let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    swagger2-pinned-github = initialPkgs.pkgs.lib.importJSON ./swagger2.json;
    swagger2 = initialPkgs.pkgs.fetchFromGitHub {
      owner = "GetShopTV";
      repo  = "swagger2";
      inherit (swagger2-pinned-github) rev sha256;
    };
  };
in
  sources.swagger2