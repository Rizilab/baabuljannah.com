let
  initialPkgs = import <nixpkgs> {};

  sources = rec {
    resolv-pinned-github = initialPkgs.pkgs.lib.importJSON ./resolv.json;
    resolv = initialPkgs.pkgs.fetchFromGitHub {
      owner = "haskell-hvr";
      repo  = "resolv";
      inherit (resolv-pinned-github) rev sha256;
    };
  };
in
  sources.resolv