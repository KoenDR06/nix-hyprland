{ hyprLib, lib, ...}: let
  inherit (lib) types mkOption;

  inherit (hyprLib.types) monitor;
in {
  options.hyprland.monitors = mkOption {
    type = types.listOf monitor;
  };
}
