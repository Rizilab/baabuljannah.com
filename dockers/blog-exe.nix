{ dockerTools, riziBackend }:
dockerTools.buildImage {
  name     = "blog-exe";
  contents = [ riziBackend.blog-server ];
  config   = {
    Cmd = [ "/bin/blog-server" ];
    WorkingDir = "/data";
    Volumes = {
      "/data" = {};
    };
    ExposedPorts = {
      "3001/tcp" = {};
    };
    Env = [
      "PORT=3001"
      "URL=http://localhost:3001"
      "PATH=/bin"
    ];
  };
}