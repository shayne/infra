{ config, ... }:
{
  services.vaultwarden = {
    enable = true;
    config = {
      ROCKET_PORT = 8080;
    };
  };

  services.reverseProxy = {
    enable = true;
    host = "vault.home.ss.ht";
    port = config.services.vaultwarden.config.ROCKET_PORT;
  };

  system.stateVersion = "23.05";
}
