let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    text-pinned-github = initialPkgs.pkgs.lib.importJSON ./text.json;
    text = initialPkgs.pkgs.fetchFromGitHub {
      owner = "haskell";
      repo  = "text";
      inherit (text-pinned-github) rev sha256;
    };
  };
in
  sources.text