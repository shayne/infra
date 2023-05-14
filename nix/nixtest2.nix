{ pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  networking.hostName = "nixtest2";

  users.users.nixtest2 = {
    isNormalUser = true;
    password = "";
    uid = 1010;
  };

  environment.systemPackages = [
    pkgs.vim
  ];

  services.openssh = { enable = true; };
}
