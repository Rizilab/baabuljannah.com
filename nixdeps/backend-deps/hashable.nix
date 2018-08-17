let
  initialPkgs = import <nixpkgs> {};

  sources = rec {
    hashable-pinned-github = initialPkgs.pkgs.lib.importJSON ./hashable.json;
    hashable = initialPkgs.pkgs.fetchFromGitHub {
      owner = "tibbe";
      repo  = "hashable";
      inherit (hashable-pinned-github) rev sha256;
    };
  };
in
  sources.hashable