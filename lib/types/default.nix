{lib, ...}: let
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

  mkCustomOptionType = name: f: options: mkOptionType {
    inherit name;
    
    check = v: isAttrs v
            && all (it: v ? "${it.name}") (attrsToList options.mandatory)
            && (!(options ? "mandatory") || (all (it:                   it.value.  check v.${it.name}) (attrsToList options.mandatory)))
            && (!(options ? "optional" ) || (all (it: !(v ? it.name) || it.value.t.check v.${it.name}) (attrsToList options.optional)))
            && (!(options ? "customCheck") || options.customCheck v);

    merge = loc: defs: let
      merged = mergeOneOption loc defs;
      defaults = lib.mkIf (options ? "optional") (mapAttrs (n: v: v.default) options.optional);
    in f (defaults // merged);
  };

  
  mkVec2 = attrs: {
    __toString = it: "{${toString it.x},${toString it.y},${toString it.z}}";
    inherit (attrs) x y z;
  };

  mkColor = attrs: let
    padHex = n: fixedWidthString 2 "0" (toHexString n);
  in {
    __toString = it: "\"#${padHex it.red}${padHex it.green}${padHex it.blue}${padHex it.alpha}\"";
    inherit (attrs) red green blue alpha;
  };

  mkGradient = attrs: {
    __toString = it: "{colors={${toString it.start},${toString it.end}},angle=${toString it.angle}}";
    inherit (attrs) start end angle;
  };

  mkCssGaps = attrs: {
    inherit (attrs) left right up down;
  };
in rec {
  vec2 = with types; mkCustomOptionType "vec2" mkVec2 {
    mandatory = {
      x = number;
      y = number;
    };
  };

  color = with types; mkCustomOptionType "color" mkColor {
    mandatory = {
      red = int;
      green = int;
      blue = int;
    };
    optional = {
      alpha = { t = number; default = 255; };
    };
  };

  css_gaps = with types; mkCustomOptionType "css_gaps" mkCssGaps {
    optional = {
      left = { t = nullOr number; default = null; };
      right = { t = nullOr number; default = null; };
      up = { t = nullOr number; default = null; };
      down = { t = nullOr number; default = null; };
    };
  };

  gradient = with types; let
    t = mkCustomOptionType "gradient" mkGradient {
      mandatory = {
        start = color;
        end = color;
        angle = number;
      };
    };
  in either color t;

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
