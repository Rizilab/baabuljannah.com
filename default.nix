let
  nixpkgs = import ./nixdeps/nixpkgs.nix;
  overlay = import ./overlay.nix;
in
  import nixpkgs {
    config = {};
    overlays = [overlay];
  }