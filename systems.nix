{
  syncthing = {
    config = ./configs/syncthing.enc.nix;
    lxc = {
      # use defaults
    };
  };

  # vaultwarden = {
  #   # config = ./configs/vaultwarden.nix;
  #   config = { config, ... }: {
  #     services.vaultwarden = {
  #       enable = true;
  #       config = { ROCKET_PORT = 8080; };
  #     };

  #     services.reverseProxy = {
  #       enable = true;
  #       host = "vw.home.ss.ht";
  #       port = config.services.vaultwarden.config.ROCKET_PORT;
  #     };

  #     system.stateVersion = "23.05";
  #   };

  #   hostname = "vw";
  #   lxc = {
  #     memory_dedicated = 1024;
  #   };
  # };
}
