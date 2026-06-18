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

      defaultTypes = if (options ? "optional") then (mapAttrs (n: v: v.t) options.optional) else {};
      mandatoryTypes = if (options ? "mandatory") then options.mandatory else {};

      value = (defaults // merged);

      applyMerges = name: type: if value ? ${name}
        then type.merge (loc ++ [name]) [{file=../../LICENSE; value=value.${name};}]
        else value.${name};

    in f (value // mapAttrs applyMerges defaultTypes // mapAttrs applyMerges mandatoryTypes);
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
      __toString = it: ''{type="bezier",points={{${toString it.x0},${toString it.y0}},{${toString it.x1},${toString it.y1}}}}'';
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
    mkAnimation = attrs: attrs // {
      __toString = it: "${categoryToLua (removeAttrs it ["__toString"])}";
    };
  in mkCustomOptionType "animation" mkAnimation {
    optional = {
      enabled = { t = bool; default = true; };
      # TODO might want to change type of style
      style = { t = nullOr str; default = null; };
      leaf = { t = nullOr (enum [
        "global" "windows" "windowsIn" "windowsOut" "windowsMove" "layers"
        "layersIn" "layersOut" "fade" "fadeIn" "fadeOut" "fadeSwitch"
        "fadeShadow" "fadeDim" "fadeLayers" "fadeLayersIn" "fadeLayersOut"
        "fadePopups" "fadePopupsIn" "fadePopupsOut" "fadeDpms" "border"
        "borderangle" "workspaces" "workspacesIn" "workspacesOut"
        "specialWorkspace" "specialWorkspaceIn" "specialWorkspaceOut"
        "zoomFactor" "monitorAdded"
      ]); default = null; };
      speed = { t = nullOr number; default = null; };
      bezier = { t = nullOr str; default = null; };
      spring = { t = nullOr str; default = null; };
    };

    customCheck = v: (v ? "enabled" && !v.enabled)
                  || (v.leaf != null && (lib.xor (v ? "spring") (v ? "bezier")) && v.speed != null);
  };

  monitor = with types; let
    mkMonitor = attrs: {
      inherit (attrs) scale mode disabled reserved_area mirror transform;

      position = if attrs.position == null then null else {
        x = attrs.position.x;
        y = attrs.position.y;
        __toString = it: ''"${toString it.x}x${toString it.y}"'';
      };
    };
  in mkCustomOptionType "monitor" mkMonitor {
    optional = {
      position = { t = nullOr vec2; default = null; };
      # TODO mode could be more type-safe
      mode = { t = nullOr str; default = null; };
      scale = { t = nullOr number; default = null; };
      disabled = { t = nullOr bool; default = null; };
      reserved_area = { t = nullOr css_gaps; default = null; };
      mirror = { t = nullOr str; default = null; };
      transform = { t = nullOr int; default = null; };
    };
  };

  bind = with types; let
    mkBind = attrs: attrs // {
      __toString = it: "hl.bind(\"${attrs.keys}\", ${attrs.dispatcher}, ${categoryToLua (removeAttrs it ["__toString" "keys" "dispatcher"])})";
    };
  in mkCustomOptionType "bind" mkBind {
    mandatory = {
      keys = str;
      dispatcher = str;
    };
    optional = {
      locked = { t = nullOr bool; default = null; };
      release = { t = nullOr bool; default = null; };
      click = { t = nullOr bool; default = null; };
      drag = { t = nullOr bool; default = null; };
      long_press = { t = nullOr bool; default = null; };
      repeating = { t = nullOr bool; default = null; };
      non_consuming = { t = nullOr bool; default = null; };
      auto_consuming = { t = nullOr bool; default = null; };
      mouse = { t = nullOr bool; default = null; };
      transparent = { t = nullOr bool; default = null; };
      ignore_mods = { t = nullOr bool; default = null; };
      dont_inhibit = { t = nullOr bool; default = null; };
      submap_universal = { t = nullOr bool; default = null; };
      device = { t = nullOr bool; default = null; };
    };
  };

  windowrule = with types; let
    mkWindowRule = attrs: attrs;
  in mkCustomOptionType "windowrule" mkWindowRule {
    mandatory = {
      # TODO improve typing
      match = attrsOf (either (either number str) bool);
    };
    optional = {
      float = { t = nullOr bool; default = null; };
      tile = { t = nullOr bool; default = null; };
      fullscreen = { t = nullOr bool; default = null; };
      maximize = { t = nullOr bool; default = null; };
      fullscreen_state = { t = nullOr str; default = null; };
      move = { t = nullOr str; default = null; };
      size = { t = nullOr str; default = null; };
      center = { t = nullOr bool; default = null; };
      pseudo = { t = nullOr bool; default = null; };
      monitor = { t = nullOr str; default = null; };
      workspace = { t = nullOr str; default = null; };
      no_initial_focus = { t = nullOr bool; default = null; };
      pin = { t = nullOr bool; default = null; };
      group = { t = nullOr str; default = null; };
      suppress_event = { t = nullOr str; default = null; };
      content = { t = nullOr str; default = null; };
      no_close_for = { t = nullOr integer; default = null; };
      scrolling_width = { t = nullOr number; default = null; };
      persistent_size = { t = nullOr bool; default = null; };
      no_max_size = { t = nullOr bool; default = null; };
      stay_focused = { t = nullOr bool; default = null; };
      animation = { t = nullOr str; default = null; };
      border_color = { t = nullOr gradient; default = null; };
      idle_inhibit = { t = nullOr str; default = null; };
      opacity = { t = nullOr str; default = null; };
      tag = { t = nullOr str; default = null; };
      max_size = { t = nullOr vec2; default = null; };
      min_size = { t = nullOr vec2; default = null; };
      border_size = { t = nullOr integer; default = null; };
      rounding = { t = nullOr integer; default = null; };
      rounding_power = { t = nullOr number; default = null; };
      allows_input = { t = nullOr bool; default = null; };
      dim_around = { t = nullOr bool; default = null; };
      decorate = { t = nullOr bool; default = null; };
      focus_on_activate = { t = nullOr bool; default = null; };
      keep_aspect_ratio = { t = nullOr bool; default = null; };
      nearest_neighbor = { t = nullOr bool; default = null; };
      no_anim = { t = nullOr bool; default = null; };
      no_blur = { t = nullOr bool; default = null; };
      no_dim = { t = nullOr bool; default = null; };
      no_focus = { t = nullOr bool; default = null; };
      no_follow_mouse = { t = nullOr bool; default = null; };
      no_shadow = { t = nullOr bool; default = null; };
      no_shortcuts_inhibit = { t = nullOr bool; default = null; };
      no_screen_share = { t = nullOr bool; default = null; };
      no_vrr = { t = nullOr bool; default = null; };
      no_auto_hdr = { t = nullOr bool; default = null; };
      opaque = { t = nullOr bool; default = null; };
      force_rgbx = { t = nullOr bool; default = null; };
      sync_fullscreen = { t = nullOr bool; default = null; };
      immediate = { t = nullOr bool; default = null; };
      xray = { t = nullOr bool; default = null; };
      render_unfocused = { t = nullOr bool; default = null; };
      scroll_mouse = { t = nullOr number; default = null; };
      scroll_touchpad = { t = nullOr number; default = null; };
      confine_pointer = { t = nullOr bool; default = null; };
      tonemap = { t = nullOr str; default = null; };
    };
  };

  workspacerule = with types; let
    mkWorkSpaceRule = attrs: attrs // {
      __toString = it: categoryToLua (removeAttrs it ["__toString"]);
    };
  in mkCustomOptionType "workspacerule" mkWorkSpaceRule {
    optional = {
      monitor = { t = nullOr str; default = null; };
      default = { t = nullOr bool; default = null; };
      gaps_in = { t = nullOr int; default = null; };
      gaps_out = { t = nullOr int; default = null; };
      border_size = { t = nullOr int; default = null; };
      no_border = { t = nullOr bool; default = null; };
      no_shadow = { t = nullOr bool; default = null; };
      no_rounding = { t = nullOr bool; default = null; };
      decorate = { t = nullOr bool; default = null; };
      persistent = { t = nullOr bool; default = null; };
      on_created_empty = { t = nullOr str; default = null; };
      default_name = { t = nullOr str; default = null; };
      layout = { t = nullOr str; default = null; };
      animation = { t = nullOr str; default = null; };
    };
  };

  layerrule = with types; let
    mkLayerRule = attrs: attrs;
  in mkCustomOptionType "layerrule" mkLayerRule {
    mandatory = {
      match = attrsOf str;
    };
    optional = {
      no_anim = { t = nullOr bool; default = null; };
      blur = { t = nullOr bool; default = null; };
      blur_popups = { t = nullOr bool; default = null; };
      ignore_alpha = { t = nullOr number; default = null; };
      dim_around = { t = nullOr bool; default = null; };
      xray = { t = nullOr bool; default = null; };
      animation = { t = nullOr str; default = null; };
      order = { t = nullOr int; default = null; };
      above_lock = { t = nullOr int; default = null; };
      no_screen_share = { t = nullOr bool; default = null; };
    };
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
