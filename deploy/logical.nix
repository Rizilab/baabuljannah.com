let
  nginxCfg = {
    enable = true;
    config = ''
      events {
        worker_connections 1024;
      }
      http {
        server {
          listen 0.0.0.0:80;
          server_name qoeifs;

          location / {
            proxy_pass http://127.0.0.1:8080/;
            proxy_set_header  Host            $host;
            proxy_set_header  X-Real-IP       $remote_addr;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
          }
        }
      }
    '';
  };

in {
  network.description = "Qoeifs network";
  network.enableRollback = true;
  qoeifs =
    { config, pkgs, ... }:
    let
      nodemon = pkgs.nodePackages.nodemon;
      qoeifs = import ../default.nix { nixpkgs = pkgs; };
      mongodb = pkgs.mongodb;
      node = pkgs.nodejs-8_x;
    in
      {
        networking.firewall.allowedTCPPorts = [ 22 80 ];
        environment.systemPackages = [ mongodb node ];
        services = {
          nginx = nginxCfg;
          mongodb = {
            enable = true;
          };
        };

        systemd.services.qoeifs-server = {
          description = "Qoeifs web app";
          after = [ "network.target" ];
          environment = {
            NODE_PORT = "8080";
            };
          path = [ node mongodb ];
          serviceConfig = {
            ExecStart = ''
              ${node}/bin/node ${qoeifs}/prod/app_hook.js
              '';
            User = "nodejs";
            
          };
        };
        #
        users = {
           extraUsers = { nodejs = { }; };
        #  defaultUserShell = "/run/current-system/sw/bin/bash";
        #  extraUsers.rizilab = {
        #    isNormalUser = true;
        #    createHome = true;
        #    uid = 1001;
        #    extraGroups = [ "networkmanager" ];
        #    home = "/home/rizilab";
        #  };
        };
        
        nix.binaryCaches = [ "https://cache.nixos.org/" "https://nixcache.reflex-frp.org" ];
        nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" ];
      };
}
