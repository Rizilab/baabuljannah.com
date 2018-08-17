let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    semigroupoids-pinned-github = initialPkgs.pkgs.lib.importJSON ./semigroupoids.json;
    semigroupoids = initialPkgs.pkgs.fetchFromGitHub {
      owner = "ekmett";
      repo  = "semigroupoids";
      inherit (semigroupoids-pinned-github) rev sha256;
    };
  };
in
  sources.semigroupoids 