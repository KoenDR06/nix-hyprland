{
  lib,
  config,
  ...
}: let
  inherit (lib) types mkIf mkOption;
  inherit (builtins) concatStringsSep;

  cfg = config.nix-hyprland.dots.hyprpaper;
  username = config.horseman.username;
  hypr = config.nix-hyprland;
in {
  options = {
    nix-hyprland.dots.hyprpaper = {
      enable = mkOption {
        default = true;
        type = types.bool;
      };
    };
  };

  config = mkIf (cfg.enable && hypr.enable) {
    home-manager.users.${username}.xdg.configFile."hypr/hyprpaper.conf".text = ''
      ${concatStringsSep "\n" (map (dis:
        if dis.wallpaper != null
        then ''
          preload = ${dis.wallpaper}
          wallpaper = ${dis.output}, ${dis.wallpaper}
        ''
        else "")
      hypr.monitors.displays)}

      preload = /home/${username}/nix-config/misc/wallpaper.jpg
      wallpaper = , /home/${username}/nix-config/misc/wallpaper.jpg
    '';
  };
}
