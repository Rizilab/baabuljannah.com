let
  ghc-compiler        = "ghc822";
  ghcjs-compiler      = "ghcjsHEAD";
  iosSdkVersion       = "10.2";
  beam-src            = import ./nixdeps/backend-deps/beam.nix;
  optparsegeneric     = import ./nixdeps/backend-deps/optparsegeneric.nix;
  servant-src         = import ./nixdeps/backend-deps/servant.nix;
  servant-auth-src    = import ./nixdeps/backend-deps/servant-auth.nix;
  cabal               = import ./nixdeps/backend-deps/cabal.nix;
  base-compat-src     = import ./nixdeps/backend-deps/base-compat.nix;
  aeson-src           = import ./nixdeps/backend-deps/aeson.nix;
  test-framework      = import ./nixdeps/backend-deps/test-framework.nix;
  system              = builtins.currentSystem;
  # inspired by obelisk's default.nix
  getReflexPlatform = sys: import (import ./nixdeps/frontend-deps/reflex-platform.nix) { inherit iosSdkVersion; system = sys; };
  reflex-platform = getReflexPlatform system;
  frontend-unminified =
    (reflex-platform.project ({ pkgs, ... }: {
      packages = {
        frontend = ./frontend/.;

      };

      shells = {
        ghcjs = ["frontend"];
      };

      overrides = self: super:
        let
          fast = p: pkgs.haskell.lib.dontHaddock (pkgs.haskell.lib.dontCheck p);
        in rec {
          reflex-dom-contrib = self.callCabal2nix "reflex-dom-contrib"
            (pkgs.fetchFromGitHub {
             owner  = "reflex-frp";
             repo   = "reflex-dom-contrib";
             rev    = "b47f90c810c838009bf69e1f8dacdcd10fe8ffe3";
             sha256 = "0yvjnr9xfm0bg7b6q7ssdci43ca2ap3wvjhshv61dnpvh60ldsk9";
            }) {};
          frontend = fast super.frontend;
        };
    })).ghcjs.frontend;


#TODO : Refactor needed to separate package form its dependencies ref: todomvc-nix
  
in
 newPkgs: oldPkgs: let
   fast = p: oldPkgs.haskell.lib.dontHaddock (oldPkgs.haskell.lib.dontCheck p);
   static = p: oldPkgs.haskell.lib.justStaticExecutables (fast p);
  in {
   # Backend Webapp
   riziBackend = oldPkgs.haskell.packages.${ghc-compiler}.override {
     overrides =
         newHaskellPkgs: oldHaskellPkgs: {
          # Import tools
          text             = newHaskellPkgs.callCabal2nix "text" (import ./nixdeps/backend-deps/text.nix) {};
          base-compat      = newHaskellPkgs.callCabal2nix "base-compat" "${base-compat-src}/base-compat" {};
          base-compat-batteries =
           newHaskellPkgs.callCabal2nix "base-compat-batteries" "${base-compat-src}/base-compat-batteries" {};
          hashable         = newHaskellPkgs.callCabal2nix "hashable" (import ./nixdeps/backend-deps/hashable.nix) {};
          unordered-containers =
            newHaskellPkgs.callCabal2nix "unordered-containers" (import ./nixdeps/backend-deps/unordered-containers.nix) {};
          scientific = newHaskellPkgs.callCabal2nix "scientific" (import ./nixdeps/backend-deps/scientific.nix) {};
          network = newHaskellPkgs.callHackage "network" "2.6.3.5" {};
          lens = newHaskellPkgs.callCabal2nix "lens" (import ./nixdeps/backend-deps/lens.nix) {};
          http-media = fast oldHaskellPkgs.http-media;
          jwt = fast oldHaskellPkgs.jwt;

          # --- Beam Related Package --- #
          beam-core        = newHaskellPkgs.callCabal2nix "beam-core" "${beam-src}/beam-core" {};
          beam-migrate     = newHaskellPkgs.callCabal2nix "beam-migrate" "${beam-src}/beam-migrate" {};
          beam-postgres    = newHaskellPkgs.callCabal2nix "beam-postgres" "${beam-src}/beam-postgres" {};
          swagger2         = fast (newHaskellPkgs.callCabal2nix "swagger2" (import ./nixdeps/backend-deps/swagger2.nix) {});

          # --- Servant Related Package --- #
          servant =
            fast (newHaskellPkgs.callCabal2nix "servant" "${servant-src}/servant" {});
          servant-server =
            newHaskellPkgs.callCabal2nix "servant-server" "${servant-src}/servant-server" {};
          servant-client =
            newHaskellPkgs.callCabal2nix "servant-client" "${servant-src}/servant-client" {};
          servant-docs =
            newHaskellPkgs.callCabal2nix "servant-docs" "${servant-src}/servant-docs" {};
          servant-swagger =
            newHaskellPkgs.callCabal2nix "servant-swagger" (import ./nixdeps/backend-deps/servant-swagger.nix) {}; 
          servant-blaze =
            newHaskellPkgs.callCabal2nix "servant-blaze" (import ./nixdeps/backend-deps/servant-blaze.nix) {};
          QuickCheck =
            newHaskellPkgs.callCabal2nix "QuickCheck" (import ./nixdeps/backend-deps/quickcheck.nix) {};
          test-framework-quickcheck2 =
            newHaskellPkgs.callCabal2nix "test-framework-quickcheck2" "${test-framework}/quickcheck2" {};
          aeson =
            newHaskellPkgs.callCabal2nix "aeson" (import ./nixdeps/backend-deps/aeson.nix) {};
          aeson-pretty =
            newHaskellPkgs.callCabal2nix "aeson-pretty" (import ./nixdeps/backend-deps/aeson-pretty.nix) {};
          aeson-compat =
            newHaskellPkgs.callCabal2nix "aeson-compat" (import ./nixdeps/backend-deps/aeson-compat.nix) {};
          lens-aeson =
            newHaskellPkgs.callCabal2nix "lens-aeson" (import ./nixdeps/backend-deps/lens-aeson.nix) {};
          attoparsec-iso8601 =
            newHaskellPkgs.callCabal2nix "attoparsec-iso8601" "${aeson-src}/attoparsec-iso8601" {};
          distributive =
            newHaskellPkgs.callCabal2nix "distributive" (import ./nixdeps/backend-deps/distributive.nix) {};
          comonad =
            newHaskellPkgs.callCabal2nix "comonad" (import ./nixdeps/backend-deps/comonad.nix) {};
          semigroupoids = newHaskellPkgs.callHackage "semigroupoids" "5.2.2" {};
          psqueues =
            newHaskellPkgs.callCabal2nix "psqueues" (import ./nixdeps/backend-deps/psqueues.nix) {};
          doctest = fast (newHaskellPkgs.callHackage "doctest" "0.15.0" {});
          exceptions = newHaskellPkgs.callHackage "exceptions" "0.10.0" {};
          temporary = newHaskellPkgs.callHackage "temporary" "1.3" {};
          transformers-compat = newHaskellPkgs.callHackage "transformers-compat" "0.6.2" {};
          resourcet = newHaskellPkgs.callHackage "resourcet" "1.2.0" {};
          conduit = newHaskellPkgs.callHackage "conduit" "1.3.0.2" {};
          free = newHaskellPkgs.callHackage "free" "5.0.1" {};
          kan-extensions = newHaskellPkgs.callHackage "kan-extensions" "5.1" {};
          adjunctions = newHaskellPkgs.callHackage "adjunctions" "4.4" {};
          hspec = fast (newHaskellPkgs.callHackage "hspec" "2.5.1" {});
          hspec-core = fast (newHaskellPkgs.callHackage "hspec-core" "2.5.1" {});
          hspec-discover = fast (newHaskellPkgs.callHackage "hspec-discover" "2.5.1" {});
          http-api-data =
            fast (newHaskellPkgs.callCabal2nix "http-api-data" (import ./nixdeps/backend-deps/http-api-data.nix) {});
          http-types =
            newHaskellPkgs.callCabal2nix "http-types" (import ./nixdeps/backend-deps/http-types.nix) {};
          mmorph =
            fast (newHaskellPkgs.callPackage (import ./nixdeps/backend-deps/mmorph.nix) {});
          quickcheck-instances =
            newHaskellPkgs.callCabal2nix "quickcheck-instances" (import ./nixdeps/backend-deps/quickcheck-instances.nix) {};
          singleton-bool =
            newHaskellPkgs.callCabal2nix "singleton-bool" (import ./nixdeps/backend-deps/singleton-bool.nix) {};
          insert-ordered-containers =
            newHaskellPkgs.callCabal2nix "insert-ordered-containers" (import ./nixdeps/backend-deps/insert-ordered-containers.nix) {};
          vault =
            newHaskellPkgs.callCabal2nix "vault" (import ./nixdeps/backend-deps/vault.nix) {};
          tasty-hspec =
            newHaskellPkgs.callCabal2nix "tasty-hspec" (import ./nixdeps/backend-deps/tasty-hspec.nix) {};
          backend-server =
            newHaskellPkgs.callPackage (import ./backend/backend.nix) {};
          backend-server-static =
            static (newHaskellPkgs.callPackage (import ./backend/backend.nix) {});
         };
   };

   # Frontend Webapp
   
   riziFrontend = frontend-unminified;
   riziFrontend-static = static frontend-unminified; 

   # Docker for backend-server
   docker-exe-static = newPkgs.callPackage ./dockers/backend-exe.nix { static = true;  };
   docker-exe        = newPkgs.callPackage ./dockers/backend-exe.nix { static = false; };
 }