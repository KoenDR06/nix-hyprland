{ lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.hyprland.env = mkOption {
    type = types.attrsOf types.str;
    default = {};
  };
}
