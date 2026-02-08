{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types mapAttrsToList;
  inherit (builtins) concatStringsSep;

  # v0.52.1

  # bezier = name, x0, y0, x1, y1
  bezier = types.submodule {
    options = {
      startX = mkOption {type = types.number;};
      startY = mkOption {type = types.number;};
      endX = mkOption {type = types.number;};
      endY = mkOption {type = types.number;};
    };
  };
  bezierToString = name: bez: "bezier = ${name}, ${toString bez.startX}, ${toString bez.startY}, ${toString bez.endX}, ${toString bez.endY}";

  # animation = name, onoff, speed, curve [,style]
  animation = let
    availableNames = ["global" "windows" "windowsIn" "windowsOut" "windowsMove" "layers" "layersIn" "layersOut" "fade" "fadeIn" "fadeOut" "fadeSwitch" "fadeShadow" "fadeDim" "fadeLayers" "fadeLayersIn" "fadeLayersOut" "fadePopups" "fadePopupsIn" "fadePopupsOut" "fadeDpms" "border" "borderangle" "workspaces" "workspacesIn" "workspacesOut" "specialWorkspace" "specialWorkspaceIn" "specialWorkspaceOut" "zoomFactor" "monitorAdded"];
  in
    types.submodule {
      options = {
        name = mkOption {
          type = types.enum availableNames;
        };
        enabled = mkOption {
          type = types.bool;
          default = true;
        };
        speed = mkOption {
          type = types.number;
        };
        style = mkOption {
          type = types.str;
          default = "";
        };
        curve = mkOption {
          type = types.nullOr bezier;
          default = null;
        };
      };
    };

  animationToString = name: data: "${
    if data.curve == null
    then ""
    else "    " + bezierToString name data.curve
  }\n    animation = ${concatStringsSep ", " (
    [
      name
      (toString data.enabled)
    ]
    ++ (
      if data.enabled
      then [
        (toString data.speed)
        name
        (data.style)
      ]
      else []
    )
  )}";
  animationsToString = anims: concatStringsSep "\n" (mapAttrsToList (name: data: animationToString name data) (removeAttrs anims ["__toString"]));
in {
  options.nix-hyprland = {
    animations = {
      animations = mkOption {
        type = types.attrsOf animation;
        default = {};
        apply = xs: xs // {__toString = animationsToString;};
      };
    };
  };
}
