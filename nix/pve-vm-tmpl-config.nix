{ config, ... }:
{
  config = {
    proxmox = {
      qemuConf = {
        virtio0 = "array:vm-9999-disk-0";
        cores = 4;
        memory = 4096;
      };
    };

    services.sshd.enable = true;
    services.nginx.enable = true;

    networking.firewall.allowedTCPPorts = [ 22 ];

    users.users.root.password = "nixos";
    services.openssh.permitRootLogin = "yes";
    services.getty.autologinUser = "root";
  };
}
