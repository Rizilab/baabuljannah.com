let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    entropy-pinned-github = initialPkgs.pkgs.lib.importJSON ./entropy.json;
    entropy = initialPkgs.pkgs.fetchFromGitHub {
      owner = "TomMD";
      repo  = "entropy";
      inherit (entropy-pinned-github) rev sha256;
    };
  };
in
  sources.entropy