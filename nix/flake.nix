{
  description = "Managed NixOS deployments";

  inputs.deploy-rs.url = "github:serokell/deploy-rs";
  inputs.tailscale = {
    url = "github:tailscale/tailscale/v1.42.0";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, deploy-rs, ... }@inputs:
    let
      mkSystems = import ./lib/mkSystems.nix { inherit nixpkgs deploy-rs; };
    in
    mkSystems {
      syncthing = ./cts/syncthing.nix;
    } //
    {
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
