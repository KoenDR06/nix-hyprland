{lib, config, ...}: let
  inherit (lib) mkOption types concatStringsSep mapAttrsToList mkOptionType attrsToList all elem attrNames;
  inherit (hyprTypes) categoryToLua minimizeCategory;

  hyprTypes = import ./types.nix { inherit lib; };

  cfg = config.hypr;

  curve_bezier_toString = v: ''{ type = "bezier", points = { {${v.x0}, ${v.y0}}, {${v.x1}, ${v.y1}} } }'';
  curve_bezier = types.addCheck curve_bezier_submod (v: v ? x0 && v ? y0 && v ? x1 && v ? y1);
  curve_bezier_submod = with types; submodule {
    options = {
      x0 = mkOption { type = number; };
      y0 = mkOption { type = number; };
      x1 = mkOption { type = number; };
      y1 = mkOption { type = number; };
    };
  };

  curve_spring_toString = v: ''{ type = "spring", mass = ${v.mass}, stiffness = ${v.stiffness}, dampening = ${v.dampening} }'';
  curve_spring = types.addCheck curve_spring_submod (v: v ? mass && v ? dampening && v ? stiffness);
  curve_spring_submod = with types; submodule {
    options = {
      mass = mkOption { type = number; };
      dampening = mkOption { type = number; };
      stiffness = mkOption { type = number; };
    };
  };

  curveToString = name: v: ''hl.curve(${name}, ${if v ? mass then curve_spring_toString v else curve_bezier_toString v})'';
  curve = types.either curve_bezier curve_spring;

  animation = let
    params = with types; {
      leaf = enum ["global" "windows" "windowsIn" "windowsOut" "windowsMove" "layers" "layersIn" "layersOut" "fade" "fadeIn" "fadeOut" "fadeSwitch" "fadeShadow" "fadeDim" "fadeLayers" "fadeLayersIn" "fadeLayersOut" "fadePopups" "fadePopupsIn" "fadePopupsOut" "fadeDpms" "border" "borderangle" "workspaces" "workspacesIn" "workspacesOut" "specialWorkspace" "specialWorkspaceIn" "specialWorkspaceOut" "zoomFactor" "monitorAdded"];
      enabled = bool;
      speed = number;
      style = str;
      bezier = nullOr str;
      spring = nullOr str;
    };
    has = a: b: a ? b && a.${b} != null;
  in mkOptionType {
      name = "animation";

      check = it: (
                     all (it: elem it.name (attrNames params)) (attrsToList it)
                     && all (it: it) (mapAttrsToList (n: v: it ? n && (v == null || v.check it.${n}) ) params)
                     # && (has it "bezier" && !(has it "spring")) || has it "spring" && !(has it "bezier")
                  ) || (it ? enabled && it.enabled == false);
  };
in {
  options.hypr = {
    curves = mkOption {
      type = types.lazyAttrsOf curve;
      default = {};
    };
    animations = mkOption {
      type = types.listOf animation;
      default = [];
    };
  };

  config = {
    hypr = {
      animations = [{
        enabled = true;
        leaf = "windows";
        speed = 3;
        bezier = "default";
        # spring = "default";
        style = "popin";
      }];
    };

    # TODO Home manager
    environment.etc."hyprland.lua".text = let
      curves_lua = concatStringsSep "\n" (mapAttrsToList curveToString cfg.curves);
      animations_lua = concatStringsSep "\n" (map (it: "hl.animation(${categoryToLua (minimizeCategory it)})") cfg.animations);
    in curves_lua + "\n" + animations_lua;
  };
}
