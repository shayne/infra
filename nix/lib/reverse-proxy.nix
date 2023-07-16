{ config, lib, options, ... }:
with lib;
let
  cfg = config.services.reverseProxy;
in {
  imports = [
    ./acme.nix
  ];

  options = {
    services.reverseProxy = {
      enable = mkEnableOption (mdDoc "Enable the reverse proxy");
      host = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "The domain name to use for the reverse proxy";
      };
      port = mkOption {
        type = types.nullOr types.int;
        default = null;
        description = "The port to proxy to";
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.host != null || cfg.port != null;
        message = "Both reverse proxy host and port must be set";
      }
      {
        assertion = cfg.host != "";
        message = "Reverse proxy host must not be empty";
      }
    ];

    networking.firewall.allowedTCPPorts = [
      config.services.nginx.defaultHTTPListenPort
      config.services.nginx.defaultSSLListenPort
    ];

    services.nginx.enable = true;
    services.nginx.virtualHosts.${cfg.host} = {
      enableACME = true;
      forceSSL = true;
      acmeRoot = null;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
      };
    };
  };
}
