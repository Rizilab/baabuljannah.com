let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    doctest-pinned-github = initialPkgs.pkgs.lib.importJSON ./doctest.json;
    doctest = initialPkgs.pkgs.fetchFromGitHub {
      owner = "sol";
      repo  = "doctest";
      inherit (doctest-pinned-github) rev sha256;
    };
  };
in
  sources.doctest