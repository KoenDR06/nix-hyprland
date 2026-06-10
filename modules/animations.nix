{ hyprLib, lib, ... }: let
  inherit (lib) mkOption types;
in {
  options.hypr = {
    curves = mkOption {
      type = types.lazyAttrsOf hyprLib.types.curve;
      default = {};
    };
    animations = mkOption {
      type = types.listOf hyprLib.types.animation;
      default = [];
    };
  };
}
