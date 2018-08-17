let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    servant-auth-pinned-github = initialPkgs.pkgs.lib.importJSON ./servant-auth.json;
    servant-auth = initialPkgs.pkgs.fetchFromGitHub {
      owner = "haskell-servant";
      repo  = "servant-auth";
      inherit (servant-auth-pinned-github) rev sha256;
    };
  };
in
  sources.servant-auth