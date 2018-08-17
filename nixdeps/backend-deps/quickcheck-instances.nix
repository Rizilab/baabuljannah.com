let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    qc-instances-pinned-github = initialPkgs.pkgs.lib.importJSON ./quickcheck-instances.json;
    qc-instances = initialPkgs.pkgs.fetchFromGitHub {
      owner = "phadej";
      repo  = "qc-instances";
      inherit (qc-instances-pinned-github) rev sha256;
    };
  };
in
  sources.qc-instances