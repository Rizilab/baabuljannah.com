let
  initialPkgs = import <nixpkgs> {};

  sources = rec {
    unordered-containers-pinned-github = initialPkgs.pkgs.lib.importJSON ./unordered-containers.json;
    unordered-containers = initialPkgs.pkgs.fetchFromGitHub {
      owner = "tibbe";
      repo  = "unordered-containers";
      inherit (unordered-containers-pinned-github) rev sha256;
    };
  };
in
  sources.unordered-containers