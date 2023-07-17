{ config, ... }: {
  config = {
    boot = {
      growPartition = true;
      kernelParams = [ "console=ttyS0" ];
      loader.grub = {
        device = "/dev/vda";
      };
      loader.timeout = 0;
      initrd.availableKernelModules = [ "uas" "virtio_blk" "virtio_pci" ];
    };

    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      autoResize = true;
      fsType = "ext4";
    };

    services.qemuGuest.enable = true;
    services.sshd.enable = true;

    networking.firewall.allowedTCPPorts = [ 22 ];

    # users.users.root.password = "nixos";
    users.users.root.hashedPassword = "!";
    # users.users.root.openssh.authorizedKeys.keys = [
    #   "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKxq71dQw4zBQAe3mtfiNwuCwP0Lu8x9PdRVxy2+T8Pw"
    # ];
    services.openssh.settings.PermitRootLogin = "yes";
    services.getty.autologinUser = "root";

    system.stateVersion = "23.05";
  };
}
