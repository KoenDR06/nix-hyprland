{lib, ...}: let
  inherit (lib) mkOption types;
  inherit (builtins) concatStringsSep;

  # v0.52.1

  # gesture = fingers, direction, action, options
  gesture = types.submodule {
    options = {
      fingers = mkOption {
        type = types.ints.positive;
      };
      direction = mkOption {
        type = types.enum ["swipe" "horizontal" "vertical" "left" "right" "up" "down" "pinch" "pinchin" "pinchout"];
      };
      mods = mkOption {
        type = types.listOf types.str;
        default = [];
      };
      scale = mkOption {
        type = types.numbers.positive;
        default = 1;
      };
      action = mkOption {
        type = types.enum ["dispatcher" "workspace" "move" "resize" "special" "close" "fullscreen" "float"];
      };
      options = mkOption {
        type = types.listOf types.str;
        default = [];
      };
    };
  };
  gestureToString = gest: "gesture = ${concatStringsSep ", " (
    [
      (toString gest.fingers)
      (gest.direction)
    ]
    ++ map (it: "mod: ${it}") gest.mods
    ++ [
      "scale: ${toString gest.scale}"
      (gest.action)
    ]
    ++ gest.options
  )}";
in {
  options.nix-hyprland = {
    gestures.gestures = mkOption {
      type = types.listOf gesture;
      default = [];
      apply = xs: map (x: x // {__toString = gest: gestureToString gest;}) xs;
    };
  };
}
