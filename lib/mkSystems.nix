{ nixpkgs, deploy-rs }:
systemDefs:
let
  utils = import ./utils.nix { lib = nixpkgs.lib; };
  mkHost = import ./mkHost.nix { inherit nixpkgs deploy-rs; };
  hostDefs =
    nixpkgs.lib.mapAttrsToList (name: attrs: mkHost { inherit name attrs; })
      systemDefs;
in
utils.recursiveMergeAttrs hostDefs
