{ nixpkgs, deploy-rs }:
pairs:
let
  mkHost = import ./mkHost.nix { inherit nixpkgs deploy-rs; };
  recursiveMergeAttrs = builtins.foldl' nixpkgs.lib.recursiveUpdate { };
  hosts = nixpkgs.lib.mapAttrsToList (name: config: mkHost { inherit name config; }) pairs;
in
recursiveMergeAttrs hosts
