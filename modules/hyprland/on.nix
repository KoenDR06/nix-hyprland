{ lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.hyprnix.hyprland.events = mkOption {
    type = types.attrsOf (types.listOf types.str);
    default = {};
  };
}
