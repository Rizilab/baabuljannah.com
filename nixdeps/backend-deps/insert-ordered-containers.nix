let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    insert-ordered-containers-pinned-github = initialPkgs.pkgs.lib.importJSON ./insert-ordered-containers.json;
    insert-ordered-containers = initialPkgs.pkgs.fetchFromGitHub {
      owner = "phadej";
      repo  = "insert-ordered-containers";
      inherit (insert-ordered-containers-pinned-github) rev sha256;
    };
  };
in
  sources.insert-ordered-containers