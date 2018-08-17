let
  initialPkgs = import <nixpkgs> {};

  sources = rec {
    tasty-pinned-github = initialPkgs.pkgs.lib.importJSON ./tasty.json;
    tasty = initialPkgs.pkgs.fetchFromGitHub {
      owner = "feuerbach";
      repo  = "tasty";
      inherit (tasty-pinned-github) rev sha256;
    };
  };
in
  sources.tasty