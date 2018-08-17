let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    network-pinned-github = initialPkgs.pkgs.lib.importJSON ./network.json;
    network = initialPkgs.pkgs.fetchFromGitHub {
      owner = "haskell";
      repo  = "network";
      inherit (network-pinned-github) rev sha256;
    };
  };
in
  sources.network