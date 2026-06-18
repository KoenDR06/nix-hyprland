{ hyprLib, lib, ...}: let
  inherit (lib) types mkOption;

  inherit (hyprLib.types) monitor;
in {
  options.hyprnix.hyprland.monitors = mkOption {
    type = types.attrsOf monitor;
    default = [];
  };
}
