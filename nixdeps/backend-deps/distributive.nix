let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    distributive-pinned-github = initialPkgs.pkgs.lib.importJSON ./distributive.json;
    distributive = initialPkgs.pkgs.fetchFromGitHub {
      owner = "ekmett";
      repo  = "distributive";
      inherit (distributive-pinned-github) rev sha256;
    };
  };
in
  sources.distributive