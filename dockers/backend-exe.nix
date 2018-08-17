{ dockerTools, riziBackend, stdenv, static ? false }:
dockerTools.buildImage {
  name     = "docker-exe";
  contents =
    if static
    then
      [ riziBackend.backend-server-static riziFrontend-static ]
    else
      [ riziBackend.backend-server riziFrontend ];
  runAsRoot = ''
    #!${stdenv.shell}
    mkdir -p /data/static
    
  '';
  config   = {
    Cmd = [ "/bin/backend-server" ];
    WorkingDir = "/data";
    Volumes = {
      "/data" = {};
    };
    ExposedPorts = {
      "3000/tcp" = {};
    };
    Env = [
      "PORT=3000"
      "URL=http://localhost:3000"
      "PATH=/bin"
    ];
  };
}