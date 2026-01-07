{
  lib,
  config,
  ...
}: let
  inherit (lib) types mkIf mkOption;
  inherit (builtins) concatStringsSep;

  cfg = config.nix-hyprland.dots.hypridle;
  username = config.horseman.username;
  hypr = config.nix-hyprland;
in {
  options = {
    nix-hyprland.dots.hypridle = {
      enable = mkOption {
        default = true;
        type = types.bool;
      };
    };
  };

  config = mkIf (cfg.enable && hypr.enable) {
    home-manager.users.${username}.xdg.configFile."hypr/hypridle.conf".text = ''
      general {
          lock_cmd = ${hypr.sleep.lockCommand}
      }

      ${concatStringsSep "\n\n" (map (lis: ''
          listener {
              timeout = ${toString lis.timeout}
              on-timeout = ${lis.onTimeout}
              on-resume = ${lis.onResume}
          }
        '')
        hypr.sleep.listeners)}
    '';
  };
}
