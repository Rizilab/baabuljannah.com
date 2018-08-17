let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    test-framework-pinned-github = initialPkgs.pkgs.lib.importJSON ./test-framework.json;
    test-framework = initialPkgs.pkgs.fetchFromGitHub {
      owner = "haskell";
      repo  = "test-framework";
      inherit (test-framework-pinned-github) rev sha256;
    };
  };
in
  sources.test-framework