let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    psqueues-pinned-github = initialPkgs.pkgs.lib.importJSON ./psqueues.json;
    psqueues = initialPkgs.pkgs.fetchFromGitHub {
      owner = "jaspervdj";
      repo  = "psqueues";
      inherit (psqueues-pinned-github) rev sha256;
    };
  };
in
  sources.psqueues