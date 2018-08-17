let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    hspec-pinned-github = initialPkgs.pkgs.lib.importJSON ./hspec.json;
    hspec = initialPkgs.pkgs.fetchFromGitHub {
      owner = "hspec";
      repo  = "hspec";
      inherit (hspec-pinned-github) rev sha256;
    };
  };
in
  sources.hspec