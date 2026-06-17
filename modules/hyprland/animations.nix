{ hyprLib, lib, ... }: let
  inherit (lib) mkOption types;

  inherit (hyprLib.types) curve animation;
in {
  options.hyprnix.hyprland = {
    curves = mkOption {
      type = types.lazyAttrsOf curve;
      default = {};
    };
    animations = mkOption {
      type = types.listOf animation;
      default = [];
    };
  };
}
