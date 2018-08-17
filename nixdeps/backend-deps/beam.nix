let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    beam-pinned-github = initialPkgs.pkgs.lib.importJSON ./beam.json;
    beam = initialPkgs.pkgs.fetchFromGitHub {
      owner = "tathougies";
      repo  = "beam";
      inherit (beam-pinned-github) rev sha256;
    };
  };
in
  sources.beam