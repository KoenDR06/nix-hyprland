{ hyprLib, lib, config, ... }: let
  hyprTypes = hyprLib.types;
  mkHyprOption = hyprTypes.mkHyprOption;
in {
  options.hyprland.config.master = {
    allow_small_split = mkHyprOption hyprTypes.bool;
    special_scale_factor = mkHyprOption hyprTypes.float;
    mfact = mkHyprOption hyprTypes.float;
    new_status = mkHyprOption hyprTypes.str;
    new_on_top = mkHyprOption hyprTypes.bool;
    new_on_active = mkHyprOption hyprTypes.str;
    orientation = mkHyprOption hyprTypes.str;
    slave_count_for_center_master = mkHyprOption hyprTypes.int;
    center_master_fallback = mkHyprOption hyprTypes.str;
    smart_resizing = mkHyprOption hyprTypes.bool;
    drop_at_cursor = mkHyprOption hyprTypes.bool;
    always_keep_position = mkHyprOption hyprTypes.bool;
    focus_master_on_close = mkHyprOption hyprTypes.bool;
  };
}
