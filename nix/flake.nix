{
  description = "Managed NixOS deployments";

  inputs.deploy-rs.url = "github:serokell/deploy-rs";

  outputs = { self, nixpkgs, deploy-rs }: {
    nixosConfigurations.nixtest2 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./nixtest2.nix ];
    };

    deploy.nodes.nixtest2 = {
      hostname = "nixtest2.home.ss.ht";
      fastConnection = true;
      profiles = {
        system = {
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nixtest2;
          user = "root";
          sshUser = "root";
        };
      };
    };

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
