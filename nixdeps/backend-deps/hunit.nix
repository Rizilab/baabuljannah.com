let
  initialPkgs = import <nixpkgs> {};

  sources = rec {
    hunit-pinned-github = initialPkgs.pkgs.lib.importJSON ./hunit.json;
    hunit = initialPkgs.pkgs.fetchFromGitHub {
      owner = "hspec";
      repo  = "hunit";
      inherit (hunit-pinned-github) rev sha256;
    };
  };
in
  sources.hunit