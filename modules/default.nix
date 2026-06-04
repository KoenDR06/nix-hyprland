{lib, config, ...}: let
  inherit (lib) mkOption types mapAttrsToList filterAttrsRecursive mapAttrs filterAttrs boolToString;
  inherit (builtins) concatStringsSep typeOf;

  cfg = config.hypr.config;

  toStringCustom = it: if (typeOf it == "bool") then (boolToString it) else (toString it);
in {
  imports = [
    ./options
  ];

  options = {
    hypr.config = {
      general = {
        border_size = mkOption {
          type = with types; nullOr int;
          default = null;
        };
        gaps_in = mkOption {
          type = with types; nullOr int;
          default = 3;
        };
      };

      decoration = {
        rounding = mkOption {
          type = with types; nullOr int;
          default = null;
        };

        blur = {
          enabled = mkOption {
            type = with types; nullOr bool;
            default = true;
          };
        };
      };
    };

    hypr.result = mkOption {
      type = types.attrs;
      readOnly = true;
    };
  };

  config = let
    removeNulls = filterAttrsRecursive (_: it: it != null);
    removeEmptySets = config: let
      res = mapAttrs (n: v: removeEmptySets v) config;
    in if typeOf config == "set" then filterAttrs (n: v: v != {}) res else config;
    minimizeCategory = config: removeEmptySets (removeNulls config);

    catComma = concatStringsSep ",";
    categoryToLua = config: "{" + catComma (mapAttrsToList (name: value: "${name}=" + (if (typeOf value == "set") then (categoryToLua value) else (toStringCustom value))) config) + "}";
  in {
    environment.etc."hyprland.lua".text = ''
      hl.config(${categoryToLua (minimizeCategory cfg)})
    '';

    hypr.result = minimizeCategory cfg;
  };
}
