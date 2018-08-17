let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    tasty-hspec-pinned-github = initialPkgs.pkgs.lib.importJSON ./tasty-hspec.json;
    tasty-hspec = initialPkgs.pkgs.fetchFromGitHub {
      owner = "mitchellwrosen";
      repo  = "tasty-hspec";
      inherit (tasty-hspec-pinned-github) rev sha256;
    };
  };
in
  sources.tasty-hspec