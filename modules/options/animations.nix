{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types strings;
  inherit (builtins) concatStringsSep;
  inherit (strings) floatToString;

  # v0.52.1

  # bezier = name, x0, y0, x1, y1
  bezier = types.submodule {
    options = {
      name = mkOption {type = types.str;};
      startX = mkOption {type = types.number;};
      startY = mkOption {type = types.number;};
      endX = mkOption {type = types.number;};
      endY = mkOption {type = types.number;};
    };
  };
  bezierToString = bez: "bezier = ${bez.name}, ${floatToString bez.startX}, ${floatToString bez.startY}, ${floatToString bez.endX}, ${floatToString bez.endY}";

  # animation = name, onoff, speed, curve [,style]
  animation = let
    availableNames = ["global" "windows" "windowsIn" "windowsOut" "windowsMove" "layers" "layersIn" "layersOut" "fade" "fadeIn" "fadeOut" "fadeSwitch" "fadeShadow" "fadeDim" "fadeLayers" "fadeLayersIn" "fadeLayersOut" "fadePopups" "fadePopupsIn" "fadePopupsOut" "fadeDpms" "border" "borderangle" "workspaces" "workspacesIn" "workspacesOut" "specialWorkspace" "specialWorkspaceIn" "specialWorkspaceOut" "zoomFactor" "monitorAdded"];
  in
    types.submodule {
      options = {
        name = mkOption {type = types.enum availableNames;};
        enabled = mkOption {
          type = types.bool;
          default = true;
        };
        speed = mkOption {type = types.number;};
        style = mkOption {
          type = types.str;
          default = "";
        };
        curve = mkOption {
          type = types.enum (["default"] ++ map (bez: bez.name) config.nix-hyprland.animations.beziers);
        };
      };
    };
  animationToString = anim: "animation = ${concatStringsSep ", " (
    [
      anim.name
      (toString anim.enabled)
    ]
    ++ (
      if anim.enabled
      then [
        (floatToString anim.speed)
        (anim.curve)
        (anim.style)
      ]
      else []
    )
  )}";
in {
  options.nix-hyprland = {
    animations = {
      beziers = mkOption {
        type = types.listOf bezier;
        default = [];
        apply = xs: map (x: x // {__toString = gest: bezierToString gest;}) xs;
      };

      animations = mkOption {
        type = types.listOf animation;
        default = [];
        apply = xs: map (x: x // {__toString = gest: animationToString gest;}) xs;
      };
    };
  };
}
