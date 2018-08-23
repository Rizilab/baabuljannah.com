{ system ? builtins.currentSystem # TODO: Get rid of this system cruft
, iosSdkVersion ? "10.2"
}:
with import ./.obelisk/impl { inherit system iosSdkVersion; };
project ./. ({ ... }: {

  android.applicationId = "systems.obsidian.obelisk.examples.minimal";
  android.displayName = "Obelisk Minimal Example";
  ios.bundleIdentifier = "systems.obsidian.obelisk.examples.minimal";
  ios.bundleName = "Obelisk Minimal Example";
  #android.applicationId = "baabuljannah.android.minimal";
  #android.displayName = "baabuljannah-android";
  #ios.bundleIdentifier = "baabuljannah.ios.minimal";
  #ios.bundleName = "baabuljannah-ios";

  overrides = newHaskellPkgs: oldHaskellPkgs: let
      #utils
      fast = nixpkgs.pkgs.haskell.lib.dontHaddock;

      ################
      #frontend stuff#
      ################
      reflex-dom-nested-routing-version  = nixpkgs.pkgs.lib.importJSON ./nixdeps/reflex-dom-nested-routing.json;
      reflex-dom-nested-routing = nixpkgs.pkgs.fetchFromGitHub {
        owner = "rizilab";
        repo  = "reflex-dom-nested-routing";
        inherit (reflex-dom-nested-routing-version) rev sha256;
      };
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
      ###############
      #backend stuff#
      ###############

    in {
      reflex-dom-storage = oldHaskellPkgs.callCabal2nix "reflex-dom-storage" reflex-dom-storage {};
      reflex-dom-nested-routing = oldHaskellPkgs.callCabal2nix "reflex-dom-nested-routing" reflex-dom-nested-routing {};
      reflex-dom-contrib = fast (oldHaskellPkgs.callCabal2nix "reflex-dom-contrib" reflex-dom-contrib {});
    };

})
