{ config, ... }: {
  config = {
    proxmox = {
      qemuConf = {
        virtio0 = "array:vm-9999-disk-0";
        cores = 4;
        memory = 4096;
      };
    };

    services.qemuGuest.enable = true;
    services.sshd.enable = true;

    networking.firewall.allowedTCPPorts = [ 22 ];
    services.cloud-init.enable = true;
    # services.cloud-init.ext4.enable = true;

    #users.users.root.password = "nixos";
    users.users.root.hashedPassword = "!";
    # users.users.root.openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKxq71dQw4zBQAe3mtfiNwuCwP0Lu8x9PdRVxy2+T8Pw"
    # ];
    services.openssh.settings.PermitRootLogin = "yes";
    services.getty.autologinUser = "root";

    system.stateVersion = "23.05";
  };
}
