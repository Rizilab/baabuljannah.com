let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    quickcheck-pinned-github = initialPkgs.pkgs.lib.importJSON ./quickcheck.json;
    quickcheck = initialPkgs.pkgs.fetchFromGitHub {
      owner = "nick8325";
      repo  = "quickcheck";
      inherit (quickcheck-pinned-github) rev sha256;
    };
  };
in
  sources.quickcheck