{ nixpkgs, deploy-rs }:
{ name, config }:
let
  domain = "home.ss.ht";
  system = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ config ];
  };
in
{
  nixosConfigurations."${name}" = system;
  deploy.nodes."${name}" = {
    hostname = "${name}.${domain}";
    fastConnection = true;
    profiles = {
      system = {
        path = deploy-rs.lib.x86_64-linux.activate.nixos system;
        user = "root";
        sshUser = "root";
      };
    };
  };
}
