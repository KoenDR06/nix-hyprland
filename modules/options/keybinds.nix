{lib, ...}: let
  inherit (lib) mkOption types;
  inherit (builtins) concatStringsSep elem;

  # v0.52.1

  # bind = mods, key, dispatcher, params
  keybind = types.submodule {
    options = {
      flags = mkOption {
        type = types.listOf (types.enum ["l" "r" "c" "g" "o" "e" "m" "t" "i" "s" "d" "p"]);
      };

      mods = mkOption {
        type = types.listOf types.str;
      };

      key = mkOption {
        type = types.str;
      };

      dispatcher = mkOption {
        type = types.enum ["exec" "execr" "pass" "sendshortcut" "sendkeystate" "killactive" "forcekillactive" "closewindow" "killwindow" "signal" "signalwindow" "workspace" "movetoworkspace" "movetoworkspacesilent" "togglefloating" "setfloating" "settiled" "fullscreen" "fullscreenstate" "dpms" "forceidle" "pin" "movefocus" "movewindow" "swapwindow" "centerwindow" "resizeactive" "moveactive" "resizewindowpixel" "movewindowpixel" "cyclenext" "swapnext" "tagwindow" "focuswindow" "focusmonitor" "splitratio" "movecursortocorner" "movecursor" "renameworkspace" "exit" "forcerendererreload" "movecurrentworkspacetomonitor" "focusworkspaceoncurrentmonitor" "moveworkspacetomonitor" "swapactiveworkspaces" "bringactivetotop" "alterzorder" "togglespecialworkspace" "focusurgentorlast" "togglegroup" "changegroupactive" "focuscurrentorlast" "lockgroups" "lockactivegroup" "moveintogroup" "moveoutofgroup" "movewindoworgroup" "movegroupwindow" "denywindowfromgroup" "setignoregrouplock" "global" "submap" "event" "setprop" "toggleswallow"];
      };

      params = mkOption {
        type = types.str;
      };
    };
  };
  keybindToString = kb: "bind${concatStringsSep "" kb.flags} = ${concatStringsSep " " kb.mods}, ${kb.key}, ${kb.dispatcher}${
    if (elem "m" kb.flags) # Mouse binds take one argument less
    then ""
    else ", ${kb.params}"
  }";

  submapKeybind = types.submodule {
    options = {
      flags = mkOption {type = types.listOf (types.enum ["l" "r" "c" "g" "o" "e" "m" "t" "i" "s" "d" "p"]);};
      mods = mkOption {type = types.listOf types.str;};
      key = mkOption {type = types.str;};
    };
  };

  submap = types.submodule {
    options = {
      name = mkOption {type = types.str;};
      enterBind = mkOption {type = submapKeybind;};
      exitBind = mkOption {type = submapKeybind;};
      binds = mkOption {type = types.listOf keybind;};
    };
  };
  submapToString = sm: ''
    bind${concatStringsSep "" sm.enterBind.flags} = ${concatStringsSep " " sm.enterBind.mods}, ${sm.enterBind.key}, submap, ${sm.name}
    submap = ${sm.name}

    ${concatStringsSep "\n" (map keybindToString sm.binds)}

    bind${concatStringsSep "" sm.exitBind.flags} = ${concatStringsSep " " sm.exitBind.mods}, ${sm.exitBind.key}, submap, reset
    submap = reset
  '';
in {
  options.nix-hyprland = {
    keybindings = {
      binds = mkOption {
        type = types.listOf keybind;
        default = [];
        apply = xs: map (x: x // {__toString = gest: keybindToString gest;}) xs;
      };

      submaps = mkOption {
        type = types.listOf submap;
        default = [];
        apply = xs: map (x: x // {__toString = gest: submapToString gest;}) xs;
      };
    };
  };
}
