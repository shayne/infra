{ nixpkgs, deploy-rs }:
with nixpkgs.lib;
{ name, attrs }:
let
  domain = "home.ss.ht";
  utils = import ./utils.nix { lib = nixpkgs.lib; };
  system = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      "${nixpkgs}/nixos/modules/virtualisation/proxmox-lxc.nix"
      ./common-lxc.nix
      attrs.config
    ];
  };
  hostname = attrs.hostname or name;
  
in utils.recursiveMergeAttrs [
  (if (attrs.lxc or null != null) then {
    terraformVars.nixos_lxc."${name}" = attrs.lxc // (
      if (name != hostname && attrs.lxc.hostname or null == null) then {
        hostname = hostname;
      } else {});
  } else {})

  {
    nixosConfigurations."${name}" = system;
    deploy.nodes."${name}" = {
      hostname = "${hostname}.${domain}";
      fastConnection = true;
      profiles = {
        system = {
          path = deploy-rs.lib.x86_64-linux.activate.nixos system;
          user = "root";
          sshUser = "root";
          sshOpts = [ "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
      };
    };
  }
]
