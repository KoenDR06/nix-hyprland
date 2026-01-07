{lib, ...}: let
  inherit (lib) mkOption types strings;
  inherit (strings) floatToString;

  # v0.52.1
  monitor = types.submodule {
    options = {
      output = mkOption {type = types.str;};
      resolution = mkOption {
        type = types.str;
        default = "highres";
      };
      refreshRate = mkOption {
        type = types.str;
        default = "highrr";
      };
      x = mkOption {type = types.int;};
      y = mkOption {type = types.int;};
      scale = mkOption {
        type = types.number;
        default = 1;
      };
      transform = mkOption {
        type = types.enum [0 1 2 3 4 5 6 7];
        default = 0;
      };
      wallpaper = mkOption {
        type = types.nullOr types.path;
        default = null;
      };
      bar = mkOption {
        type = types.enum ["" "left" "right" "top" "bottom"];
        default = "";
      };
    };
  };
  monitorToString = mon: "monitor = ${mon.output}, ${mon.resolution}@${mon.refreshRate}, ${toString mon.x}x${toString mon.y}, ${floatToString mon.scale}, transform, ${toString mon.transform}";
in {
  options.nix-hyprland = {
    monitors = {
      addDefault = mkOption {type = types.bool;};
      bindWorkspaces = mkOption {
        type = types.enum ["no" "interlaced"];
        default = "no";
      };

      displays = mkOption {
        type = types.listOf monitor;
        default = [];
        apply = xs: map (x: x // {__toString = gest: monitorToString gest;}) xs;
      };
    };
  };
}
