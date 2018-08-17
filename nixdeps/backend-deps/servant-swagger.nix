let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    servant-swagger-pinned-github = initialPkgs.pkgs.lib.importJSON ./servant-swagger.json;
    servant-swagger = initialPkgs.pkgs.fetchFromGitHub {
      owner = "haskell-servant";
      repo  = "servant-swagger";
      inherit (servant-swagger-pinned-github) rev sha256;
    };
  };
in
  sources.servant-swagger