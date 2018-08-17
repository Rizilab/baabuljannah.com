#! /usr/bin/env bash
nix-prefetch-git https://github.com/haskell/cabal > cabal.json
nix-prefetch-git https://github.com/haskell-compat/base-compat > base-compat.json
nix-prefetch-git https://github.com/haskell/text > text.json
nix-prefetch-git https://github.com/TomMD/entropy > entropy.json
nix-prefetch-git https://github.com/GetShopTV/swagger2 > swagger2.json
nix-prefetch-git https://github.com/Gabriel439/Haskell-Optparse-Generic-Library > optparsegeneric.json
nix-prefetch-git https://github.com/tathougies/beam                             > beam.json
nix-prefetch-git https://github.com/haskell-servant/servant                     > servant.json
nix-prefetch-git https://github.com/haskell-servant/servant-auth                > servant-auth.json
nix-prefetch-git https://github.com/haskell-servant/servant-blaze               > servant-blaze.json
nix-prefetch-git https://github.com/haskell-servant/servant-swagger             > servant-swagger.json

# download latest release stable nix-channel
# current nix-channel: 18.03
# nix version 2.0

nix-prefetch-git https://github.com/NixOS/nixpkgs-channels --rev 91b286c8935b8c5df4a99302715200d3bd561977 > ../nixpkgs.json

