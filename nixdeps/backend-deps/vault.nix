let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    vault-pinned-github = initialPkgs.pkgs.lib.importJSON ./vault.json;
    vault = initialPkgs.pkgs.fetchFromGitHub {
      owner = "HeinrichApfelmus";
      repo  = "vault";
      inherit (vault-pinned-github) rev sha256;
    };
  };
in
  sources.vault