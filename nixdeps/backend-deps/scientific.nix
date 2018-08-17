let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    scientific-pinned-github = initialPkgs.pkgs.lib.importJSON ./scientific.json;
    scientific = initialPkgs.pkgs.fetchFromGitHub {
      owner = "basvandijk";
      repo  = "scientific";
      inherit (scientific-pinned-github) rev sha256;
    };
  };
in
  sources.scientific