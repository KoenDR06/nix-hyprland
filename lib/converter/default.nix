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

  toKVLines = it: concatLines (mapAttrsToList (n: v: "${n} = ${toStringCustom v}") it);
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

  hyprland.configToString = config: ''
    hl.config(${categoryToLua config.config})

    ${concatLines (mapAttrsToList (name: value: ''hl.curve("${name}",${toString value})'') config.curves)}
    ${concatLines (map (it: ''hl.animation(${toString it})'') config.animations)}
    ${concatLines (map (it: toString it) config.binds)}
    ${concatLines (mapAttrsToList (n: v: ''hl.monitor(${categoryToLua (v // {output=n;})})'') config.monitors)}
    ${concatLines (mapAttrsToList (n: v: ''hl.window_rule(${categoryToLua (v // {name=n;})})'') config.windowrules)}
    ${concatLines (mapAttrsToList (n: v: ''hl.layer_rule(${categoryToLua (v // {name=n;})})'') config.layerrules)}
    ${concatLines (mapAttrsToList (n: v: ''hl.workspace_rule(${toString ({workspace=n;}//v)})'') config.workspacerules)}
    ${concatLines (mapAttrsToList (n: v: ''hl.env("${n}",${v})'') config.env)}
    ${concatLines (mapAttrsToList (n: v: ''hl.on("${n}",${v})'') config.events)}
  '';

  hyprpaper.configToString = config: let
    config' = minimizeCategory config;
  in ''
    ${toKVLines (removeAttrs config' ["wallpapers" "enable"])}
    ${concatLines (mapAttrsToList (n: v: "wallpaper {\n${toKVLines v}}") config.wallpapers)}
  '';

  hypridle.configToString = config: let
    settings = minimizeCategory config.general;
  in ''
    ${toKVLines settings}
    ${concatLines (map (it: "listener {\n${toKVLines it}}") config.listeners)}
  '';
}
