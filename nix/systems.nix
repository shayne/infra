{
  syncthing = {
    config = ./cts/syncthing.enc.nix;
    lxc = {
      # use defaults
    };
  };

  # vaultwarden = {
  #   config = ./cts/vaultwarden.nix;
  #   hostname = "vw";
  #   lxc = {
  #     memory_dedicated = 1024;
  #   };
  # };
}
