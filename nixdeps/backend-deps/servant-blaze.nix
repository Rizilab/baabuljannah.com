let
  fetchPkgs   = import ./nixpkgs.nix;
  initialPkgs = import fetchPkgs {};

  sources = rec {
    servant-blaze-pinned-github = initialPkgs.pkgs.lib.importJSON ./servant-blaze.json;
    servant-blaze = initialPkgs.pkgs.fetchFromGitHub {
      owner = "haskell-servant";
      repo  = "servant-blaze";
      inherit (servant-blaze-pinned-github) rev sha256;
    };
  };
in
  sources.servant-blaze