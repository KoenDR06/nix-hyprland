{lib,...}: let
  inherit (lib) types mkOption typeOf toHexString fixedWidthString mapAttrsToList filterAttrsRecursive mapAttrs filterAttrs boolToString mkOptionType;
  inherit (builtins) concatStringsSep;
in rec {
  mkHyprOption = type: strf: mkOption {
    type = types.nullOr type;
    default = null;
  } // (if strf != null then {
    apply = it: if typeOf it == "set" then it // { __toString = it: strf it; } else it;
  } else {});

  mkCustomOptionType = name: vals: mkOptionType {
    inherit name;

    check = it: lib.length (lib.attrNames it) == lib.length (lib.attrNames vals)
             && lib.all (it: it) (mapAttrsToList (n: v: it ? n && (v == null || v.check it.${n}) ) vals);
  };

  vec2_toString = it: "{${toString it.x},${toString it.y}}";
  vec2 = mkCustomOptionType "vec2" {
    x = types.number;
    y = types.number;
  };

  css_gaps   = with types; either number css_gaps_t;
  css_gaps_t = with types; mkCustomOptionType "css_gaps" {
    left = nullOr number;
    right = nullOr number;
    up = nullOr number;
    down = nullOr number;
  };
  
  font_weight = with types; either int (enum ["thin" "ultralight" "light" "semilight" "book" "normal" "medium" "semibold" "bold" "ultrabold" "heavy" "ultraheavy"]);

  padHex = n: fixedWidthString 2 "0" (toHexString n);
  color_toString = it: "\"#${padHex it.red}${padHex it.green}${padHex it.blue}${padHex it.alpha}\"";
  color = types.addCheck color_submod (v: v ? red && v ? green && v ? blue);
  color_submod = with types; submodule {
    options = {
      red = mkOption { type = int; };
      green = mkOption { type = int; };
      blue = mkOption { type = int; };
      alpha = mkOption {
        type = int;
        default = 255;
      };
    };
  };

  gradient_only_toString = it: "{colors={${color_toString it.start},${color_toString it.end}},angle=${toString it.angle}}";
  gradient_only = types.addCheck gradient_only_submod (v: v ? start && v ? end && v ? angle);
  gradient_only_submod = with types; submodule {
    options = {
      start = mkOption { type = color; };
      end = mkOption { type = color; };
      angle = mkOption {
        type = number;
        default = 45;
      };
    };
  };

  gradient_toString = it: if it ? "red" then color_toString it else gradient_only_toString it;
  gradient = types.either color gradient_only;



  ### Util functions ###
  
  removeNulls = filterAttrsRecursive (_: it: it != null);
  removeEmptySets = config: let
    res = mapAttrs (n: v: removeEmptySets v) config;
  in if typeOf config == "set" then filterAttrs (n: v: v != {}) res else config;
  minimizeCategory = config: removeEmptySets (removeNulls config);

  catComma = concatStringsSep ",";
  categoryToLua = config: "{" + catComma (mapAttrsToList (name: value: "${name}=" + (if (value ? "__toString") then (toString value) else if (typeOf value == "set") then (categoryToLua value) else (toStringCustom value))) config) + "}";

  toStringCustom = it:
    if (typeOf it == "bool")
    then (boolToString it)
    else
      if (typeOf it == "string")
      then "\"${toString it}\""
      else (toString it);
  
  int = types.int;
  float = types.number;
  bool = types.bool;
  string = types.str;
  str = types.str;
}

