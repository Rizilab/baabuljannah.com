let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    servant-pinned-github = initialPkgs.pkgs.lib.importJSON ./servant.json;
    servant = initialPkgs.pkgs.fetchFromGitHub {
      owner = "haskell-servant";
      repo  = "servant";
      inherit (servant-pinned-github) rev sha256;
    };
  };
in
  sources.servant