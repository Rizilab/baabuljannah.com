{}:

(import (import ../nixdeps/frontend-deps/reflex-platform.nix) {}).project ({ pkgs, ... }: {
  packages = {
    frontend = ./.;
      
  };
  
  shells = {
    ghcjs = ["frontend"];
  };
  
  overrides = self: super:
    let
      fast = p: pkgs.haskell.lib.dontHaddock (pkgs.haskell.lib.dontCheck p);
      reflex-dom-nested-routing  = ../reflex-dom-nested-routing;
      reflex-dom-storage-version = nixpkgs.pkgs.lib.importJSON ./nixdeps/reflex-dom-storage.json;
      reflex-dom-storage = nixpkgs.pkgs.fetchFromGitHub {
        owner = "qfpl";
        repo  = "reflex-dom-storage";
        inherit (reflex-dom-storage-version) rev sha256;
      };
      reflex-dom-contrib-version = nixpkgs.pkgs.lib.importJSON ./nixdeps/reflex-dom-contrib.json;
      reflex-dom-contrib = nixpkgs.pkgs.fetchFromGitHub {
        owner = "reflex-frp";
        repo = "reflex-dom-contrib";
        inherit (reflex-dom-contrib-version) rev sha256;
      };

    in rec {
      reflex-dom-storage = super.callCabal2nix "reflex-dom-storage" reflex-dom-storage {};
      reflex-dom-nested-routing = super.callCabal2nix "reflex-dom-nested-routing" reflex-dom-nested-routing {};
      reflex-dom-contrib = fast (super.callCabal2nix "reflex-dom-contrib" reflex-dom-contrib {});
      frontend = fast super.frontend;
    };
   
})
