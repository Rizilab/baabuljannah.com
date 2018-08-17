let
  fetchPkgs   = import ./../nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    reflex-platform-pinned-github = initialPkgs.pkgs.lib.importJSON ./reflex-platform.json;
    reflex-platform = initialPkgs.pkgs.fetchFromGitHub {
      owner = "reflex-frp";
      repo  = "reflex-platform";
      inherit (reflex-platform-pinned-github) rev sha256;
    };
  };

  reflex-platform = sources.reflex-platform;

in
<<<<<<< HEAD
  reflex-platform
=======
  reflex-platform

                                                                                                                       66
>>>>>>> origin/master
