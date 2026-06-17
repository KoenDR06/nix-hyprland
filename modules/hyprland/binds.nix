{ hyprLib, lib, ...}: let
  inherit (lib) types mkOption;

  inherit (hyprLib.types) bind;
in {
  options.hyprnix.hyprland.binds = mkOption {
    type = types.listOf bind;
    default = [];
  };
}

