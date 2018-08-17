let
  pkgs = import ./.;
in
  with pkgs;
  mkShell {
    inputsFrom = [
      riziBackend.backend-exe
    ];

    nativeBuildInputs = [
      git
    ];

    buildInputs = [
      riziBackend.ghc
      riziBackend.ghcid
    ];
  }
