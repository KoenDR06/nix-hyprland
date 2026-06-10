{lib, ...}: let
  inherit (lib)
    boolToString
    concatLines
    concatStringsSep
    filterAttrs
    filterAttrsRecursive
    mapAttrs
    mapAttrsToList
    typeOf;
  
  removeNulls = filterAttrsRecursive (_: it: it != null);
  removeEmptySets = config: let
    res = mapAttrs (n: v: removeEmptySets v) config;
  in if typeOf config == "set" then filterAttrs (n: v: v != {}) res else config;
  minimizeCategory = config: removeEmptySets (removeNulls config);

  catComma = concatStringsSep ",";

  toStringCustom = it:
    if (typeOf it == "bool")
    then (boolToString it)
    else
      if (typeOf it == "string")
      then "\"${toString it}\""
      else (toString it);
in rec {
  categoryToLua = config: "{" + catComma (
    mapAttrsToList (name: value:
      "${name}=" + (
        if (value ? "__toString")
        then (toString value)
        else if (typeOf value == "set")
          then (categoryToLua value)
          else (toStringCustom value)
      )
    ) (minimizeCategory config)
  ) + "}";

  toLua = config: ''
    hl.config(${categoryToLua config.config})

    ${concatLines (mapAttrsToList (name: value: ''hl.curve("${name}",${toString value})'') config.curves)}
    ${concatLines (map (anim: ''hl.animation(${toString anim})'') config.animations)}
  '';
}
