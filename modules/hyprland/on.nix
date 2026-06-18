{ lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.hyprnix.hyprland.events = mkOption {
    type = types.attrsOf (types.str);
    default = {};
  };
}
