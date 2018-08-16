#!/usr/bin/env bash
set -euo pipefail

echo "Menjalankan script scss"

sass --update --scss --force -C --sourcemap=none --stop-on-error -t compressed \
     ./static/stylesheet/main.scss:./static/index.css

echo "Menjalankan nix-build untuk membuat derivasi"
nix-build default.nix
