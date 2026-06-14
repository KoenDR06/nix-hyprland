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
    ${concatLines (map (it: ''hl.animation(${toString it})'') config.animations)}
    ${concatLines (map (it: ''hl.monitor(${toString it})'') config.monitors)}
    ${concatLines (map (it: toString it) config.binds)}
    ${concatLines (mapAttrsToList (n: v: ''hl.window_rule(name = "${n}", ${toString v})'') config.windowrules)}
    ${concatLines (mapAttrsToList (n: v: ''hl.layer_rule(name = "${n}", ${toString v})'') config.layerrules)}
    ${concatLines (mapAttrsToList (n: v: ''hl.workspace_rule(${toString ({workspace=n;}//v)})'') config.workspacerules)}
    ${concatLines (mapAttrsToList (n: v: ''hl.env("${n}",${v})'') config.env)}
    ${concatLines (map (it: ''hl.on("${it.name}",${it.value})'') (
      lib.flatten (
        lib.mapAttrsToList
          (n: v: map (it: {name=n;value=it;}) v)
          config.events
      )
    ))}
  '';
}
