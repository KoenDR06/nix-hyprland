{config, lib, ...}: let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types;

  cfg = config.hyprnix.hyprpaper;
in {
  options.hyprnix.hyprpaper = {
    enable = mkEnableOption "Whether to enable hyprpaper, hyprland's wallpaper manager";

    autoStart = mkOption {
      type = types.bool;
      default = false;
    };
    splash = mkOption {
      type = types.nullOr types.bool;
      default = null;
    };
    splash_opacity = mkOption {
      type = types.nullOr types.number;
      default = null;
    };
    ipc = mkOption {
      type = types.nullOr types.bool;
      default = null;
    };

    wallpapers = with types; mkOption {
      type = attrsOf (submodule {
        options = {
          path = mkOption {
            type = path;
          };
          fit_mode = mkOption {
            type = nullOr (enum ["contain" "cover" "tile" "fill"]);
            default = null;
          };
          timeout = mkOption {
            type = nullOr int;
            default = null;
          };
          order = mkOption {
            type = nullOr (enum ["random"]);
            default = null;
          };
          recursive = mkOption {
            type = nullOr bool;
            default = null;
          };
        };
      });
    };
  };

  config = mkIf (cfg.enable && cfg.autoStart) {
    hyprnix.hyprland.events."hyprland.start" = [ ''hl.dsp.exec_cmd("hyprpaper")'' ];
  };
}
