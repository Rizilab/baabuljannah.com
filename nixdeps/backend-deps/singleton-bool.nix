let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    singleton-bool-pinned-github = initialPkgs.pkgs.lib.importJSON ./singleton-bool.json;
    singleton-bool = initialPkgs.pkgs.fetchFromGitHub {
      owner = "phadej";
      repo  = "singleton-bool";
      inherit (singleton-bool-pinned-github) rev sha256;
    };
  };
in
  sources.singleton-bool