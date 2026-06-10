{ converter, lib, ...}: let
  inherit (lib)
    all
    attrsToList
    fixedWidthString
    mapAttrs
    mergeOneOption
    mkOption
    mkOptionType
    toHexString
    types;
  inherit (builtins) isAttrs;

  inherit (converter) categoryToLua;

  mkCustomOptionType = name: f: options: mkOptionType {
    inherit name;
    
    check = v: isAttrs v
            && (!(options ? "mandatory") || (all (it: v ? "${it.name}") (attrsToList options.mandatory)))
            && (!(options ? "mandatory") || (all (it:                   it.value.  check v.${it.name}) (attrsToList options.mandatory)))
            && (!(options ? "optional" ) || (all (it: !(v ? it.name) || it.value.t.check v.${it.name}) (attrsToList options.optional)))
            && (!(options ? "customCheck") || options.customCheck v);

    merge = loc: defs: let
      merged = mergeOneOption loc defs;
      defaults = if (options ? "optional") then (mapAttrs (n: v: v.default) options.optional) else {};
    in f (defaults // merged);
  };
in rec {
  vec2 = with types; let
    mkVec2 = attrs: {
      __toString = it: "{${toString it.x},${toString it.y},${toString it.z}}";
      inherit (attrs) x y z;
    };
  in mkCustomOptionType "vec2" mkVec2 {
    mandatory = {
      x = number;
      y = number;
    };
  };

  color = with types; let
    mkColor = attrs: let
      padHex = n: fixedWidthString 2 "0" (toHexString n);
    in {
      __toString = it: "\"#${padHex it.red}${padHex it.green}${padHex it.blue}${padHex it.alpha}\"";
      inherit (attrs) red green blue alpha;
    };
  in mkCustomOptionType "color" mkColor {
    mandatory = {
      red = int;
      green = int;
      blue = int;
    };
    optional = {
      alpha = { t = number; default = 255; };
    };
  };

  css_gaps = with types; let
    mkCssGaps = attrs: {
      inherit (attrs) left right up down;
    };
    t = mkCustomOptionType "css_gaps" mkCssGaps {
      optional = {
        left = { t = nullOr number; default = null; };
        right = { t = nullOr number; default = null; };
        up = { t = nullOr number; default = null; };
        down = { t = nullOr number; default = null; };
      };
    };
  in either int t;

  gradient = with types; let
    mkGradient = attrs: {
      __toString = it: "{colors={${toString it.start},${toString it.end}},angle=${toString it.angle}}";
      inherit (attrs) start end angle;
    };
    t = mkCustomOptionType "gradient" mkGradient {
      mandatory = {
        start = color;
        end = color;
        angle = number;
      };
    };
  in either color t;

  curve = with types; let
    mkSpringCurve = attrs: {
      __toString = it: "{${categoryToLua ({inherit (attrs) mass stiffness dampening;} // { type="spring"; })}}";
      inherit (attrs) mass stiffness dampening;
    };

    mkBezierCurve = attrs: {
      __toString = it: ''{type="bezier",points={{${toString it.x0},${toString it.y0}}{${toString it.x1},${toString it.y1}}}}'';
      inherit (attrs) x0 y0 x1 y1;
    };
    spring = mkCustomOptionType "springCurve" mkSpringCurve {
      mandatory = {
        stiffness = number;
        dampening = number;
      };
      optional = {
        mass = { t = number; default = 1; };
      };
    };
    bezier = mkCustomOptionType "bezierCurve" mkBezierCurve {
      mandatory = {
        x0 = numbers.between 0 1;
        y0 = number;
        x1 = numbers.between 0 1;
        y1 = number;
      };
    };
  in either spring bezier;

  animation = with types; let
    mkAnimation = attrs: {
      __toString = it: "{${categoryToLua ({inherit (attrs) enabled style leaf speed curve;} // { type="spring"; })}}";
      inherit (attrs) enabled style leaf speed curve;
    };
  in mkCustomOptionType "animation" mkAnimation {
    optional = {
      enabled = { type = bool; default = true; };
      # TODO might want to change type of style
      style = { type = nullOr str; default = null; };
      leaf = { type = nullOr enum [
        "global" "windows" "windowsIn" "windowsOut" "windowsMove" "layers"
        "layersIn" "layersOut" "fade" "fadeIn" "fadeOut" "fadeSwitch"
        "fadeShadow" "fadeDim" "fadeLayers" "fadeLayersIn" "fadeLayersOut"
        "fadePopups" "fadePopupsIn" "fadePopupsOut" "fadeDpms" "border"
        "borderangle" "workspaces" "workspacesIn" "workspacesOut"
        "specialWorkspace" "specialWorkspaceIn" "specialWorkspaceOut"
        "zoomFactor" "monitorAdded"
      ]; default = null; };
      speed = { type = nullOr number; default = null; };
      curve = { type = nullOr str; default = null; };
    };

    customCheck = v: (v ? "enabled" && !v.enabled) || (v.leaf != null && v.curve != null && v.speed != null);
  };

  font_weight = with types; either int (enum ["thin" "ultralight" "light" "semilight" "book" "normal" "medium" "semibold" "bold" "ultrabold" "heavy" "ultraheavy"]);
  int = types.int;
  float = types.number;
  bool = types.bool;
  str = types.str;


  
  mkHyprOption = type: mkOption {
    type = types.nullOr type;
    default = null;
  };
}
