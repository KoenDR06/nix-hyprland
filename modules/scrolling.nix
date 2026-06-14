{ hyprLib, lib, config, ... }: let
  hyprTypes = hyprLib.types;
  mkHyprOption = hyprTypes.mkHyprOption;
in {
  options.hyprland.config.scrolling = {
    fullscreen_on_one_column = mkHyprOption hyprTypes.bool;
    column_width = mkHyprOption hyprTypes.float;
    focus_fit_method = mkHyprOption hyprTypes.int;
    follow_focus = mkHyprOption hyprTypes.bool;
    follow_min_visible = mkHyprOption hyprTypes.float;
    explicit_column_widths = mkHyprOption hyprTypes.str;
    wrap_focus = mkHyprOption hyprTypes.bool;
    wrap_swapcol = mkHyprOption hyprTypes.bool;
    direction = mkHyprOption hyprTypes.str;
  };
}

