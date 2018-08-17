let
  initialPkgs = import <nixpkgs> {};

  sources = rec {
    parsec-pinned-github = initialPkgs.pkgs.lib.importJSON ./parsec.json;
    parsec = initialPkgs.pkgs.fetchFromGitHub {
      owner = "haskell";
      repo  = "parsec";
      inherit (parsec-pinned-github) rev sha256;
    };
  };
in
  sources.parsec