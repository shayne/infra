{ lib, ... }:
with lib;
let
  mkMagicMergeOption = { description ? "", example ? { }, default ? { }, ... }:
    mkOption {
      inherit example description default;
      type = with lib.types;
        let
          valueType = nullOr
            (oneOf [
              bool
              int
              float
              str
              path
              (functionTo attrs)
              (attrsOf valueType)
              (listOf valueType)
            ]) // {
            description = "bool, int, float or str";
            emptyValue.value = { };
          };
        in
        valueType;
    };
in
{

  options = {
    pve = mkMagicMergeOption {
      description = ''
        FOO BAR
      '';
    };
  };
}
