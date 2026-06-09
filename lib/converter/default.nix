{lib, ...}: let
  inherit (lib)
    boolToString
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
  categoryToLua = config: "{" + catComma (mapAttrsToList (name: value: "${name}=" + (if (value ? "__toString") then (toString value) else if (typeOf value == "set") then (categoryToLua value) else (toStringCustom value))) config) + "}";

  toStringCustom = it:
    if (typeOf it == "bool")
    then (boolToString it)
    else
      if (typeOf it == "string")
      then "\"${toString it}\""
      else (toString it);
in {
  toLua = config: ''
    hl.config(${categoryToLua (minimizeCategory config.config)})
  '';
}
