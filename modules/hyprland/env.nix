{ lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.hyprnix.hyprland.env = mkOption {
    type = types.attrsOf types.str;
    default = {};
  };
}
