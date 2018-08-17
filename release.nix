let
  pkgs = import ./.;
  frontend = pkgs.riziFrontend {};
in
  with pkgs;
  stdenv.mkDerivation rec {
    name = "rizi-exe";
    src = ./.;
    unpackPhase =''
      #cp -r . $src/
    '';
    buildPhase =''
      export LANG=en_US.UTF-8
      export LOCALE_ARCHIVE=/run/current-system/sw/lib/locale/locale-archive
    '';
    installPhase =''
      mkdir -p $out/prod
      mkdir -p $out/prod/static
      cp -rf ${frontend}/ghcjs/frontend/bin/frontend.jsexe/* $out/prod/
      cp -rf $src/static/* $out/prod/static/.
    '';
    phases = ["unpackPhase" "buildPhase" "installPhase"];
    buildInputs = [];
  }
