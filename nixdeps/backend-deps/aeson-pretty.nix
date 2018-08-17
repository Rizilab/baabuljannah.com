let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    aeson-pretty-pinned-github = initialPkgs.pkgs.lib.importJSON ./aeson-pretty.json;
    aeson-pretty = initialPkgs.pkgs.fetchFromGitHub {
      owner = "informatikr";
      repo  = "aeson-pretty";
      inherit (aeson-pretty-pinned-github) rev sha256;
    };
  };
in
  sources.aeson-pretty