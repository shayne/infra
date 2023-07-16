{
  description = "Managed NixOS deployments";

  inputs = {
    deploy-rs.url = "github:serokell/deploy-rs";
    flake-utils.url = "github:numtide/flake-utils";
    terranix = {
      url = "github:terranix/terranix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tailscale = {
      url = "github:tailscale/tailscale/v1.42.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, deploy-rs, terranix, ... }@inputs:
    with flake-utils.lib;
    let
      mkSystems = import ./lib/mkSystems.nix { inherit nixpkgs deploy-rs; };
    in
    mkSystems (import ./systems.nix) //
    eachSystem [ system.x86_64-linux ] (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      # terraformConfiguration = terranix.lib.terranixConfiguration {
      #   inherit system;
      #   modules = [ self.terraformConfiguration ];
      # };
      tfvars = pkgs.writeText "terraform.tfvars.json" (builtins.toJSON self.terraformVars);
    in {
      apps.apply = {
        type = "app";
        program = toString (pkgs.writers.writeBash "apply" ''
          chmod +rw ../terraform/terraform.tfvars.json
          cp ${tfvars} ../terraform/terraform.tfvars.json
          cd ../terraform && terraform apply
        '');
      };

      apps.default = self.apps.${system}.apply;

      checks = deploy-rs.lib.${system}.deployChecks self.deploy;
    });
}
