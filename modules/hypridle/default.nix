{config, lib, ...}: let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types;

  cfg = config.hyprnix.hypridle;

  mkHyprOption = t: mkOption {
    type = types.nullOr t;
    default = null;
  };
in {
  options.hyprnix.hypridle = {
    enable = mkEnableOption "Whether to enable hypridle, hyprland's sleep manager";

    general = with types; {
      lock_cmd = mkHyprOption str;
      unlock_cmd = mkHyprOption str;
      on_lock_cmd = mkHyprOption str;
      on_unlock_cmd = mkHyprOption str;
      before_sleep_cmd = mkHyprOption str;
      after_sleep_cmd = mkHyprOption str;
      ignore_dbus_inhibit = mkHyprOption bool;
      ignore_systemd_inhibit = mkHyprOption bool;
      ignore_wayland_inhibit = mkHyprOption bool;
      inhibit_sleep = mkHyprOption int;
    };

    listeners = with types; mkOption {
      type = listOf (submodule {
        options = {
          timeout = mkOption {
            type = int;
          };
          on-timeout = mkOption {
            type = nullOr str;
            default = null;
          };
          on-resume = mkOption {
            type = nullOr str;
            default = null;
          };
          ignore_inhibit = mkOption {
            type = nullOr bool;
          };
        };
      });
      default = {};
    };
  };
}

