{ nixpkgs, deploy-rs }:
with nixpkgs.lib;
with builtins;
configuration:
let
  strip_nulls = true;
  # sanitize the resulting configuration
  # removes unwanted parts of the evalModule output
  sanitize = configuration:
    getAttr (typeOf configuration) {
      bool = configuration;
      int = configuration;
      string = configuration;
      str = configuration;
      list = map sanitize configuration;
      null = null;
      path = configuration;
      lambda = configuration;
      set =
        let
          stripped_a = flip filterAttrs configuration
            (name: value: name != "_module" && name != "_ref");
          stripped_b = flip filterAttrs configuration
            (name: value: name != "_module" && name != "_ref" && value != null);
          recursiveSanitized =
            if strip_nulls then
              mapAttrs (const sanitize) stripped_b
            else
              mapAttrs (const sanitize) stripped_a;
        in
        if (length (attrNames configuration) == 0) then
          { }
        else
          recursiveSanitized;
    };
  evaluateConfiguration = configuration:
    nixpkgs.lib.evalModules {
      modules = [
        { imports = [ ../modules ]; }
        { _module.args = { inherit pkgs; }; }
        configuration
      ];
    };
  evaluated = evaluateConfiguration configuration;
  result = sanitize evaluated.config;
  genericWhitelist = f: key:
    let attr = f result.${key};
    in
    if attr == { } || attr == null
    then { }
    else {
      ${key} = attr;
    };
  whitelist = genericWhitelist id;
  whitelistWithoutEmpty = genericWhitelist (filterAttrs (name: attr: attr != { }));

  config = { } //
    (whitelist "pve");

  utils = import ./utils.nix { lib = nixpkgs.lib; };
  mkHost = import ./mkHost.nix { inherit nixpkgs deploy-rs; };
  hostDefs =
    nixpkgs.lib.mapAttrsToList
      (name: attrs: mkHost { inherit name attrs; })
      config.pve;
in
utils.recursiveMergeAttrs hostDefs
