{ hyprLib, lib, config, ... }: let
  hyprTypes = hyprLib.types;
  mkHyprOption = hyprTypes.mkHyprOption;
in {
  options.hyprnix.hyprland.config.dwindle = {
    force_split = mkHyprOption hyprTypes.int;
    preserve_split = mkHyprOption hyprTypes.bool;
    smart_split = mkHyprOption hyprTypes.bool;
    smart_resizing = mkHyprOption hyprTypes.bool;
    permanent_direction_override = mkHyprOption hyprTypes.bool;
    special_scale_factor = mkHyprOption hyprTypes.float;
    split_width_multiplier = mkHyprOption hyprTypes.float;
    use_active_for_splits = mkHyprOption hyprTypes.bool;
    default_split_ratio = mkHyprOption hyprTypes.float;
    split_bias = mkHyprOption hyprTypes.int;
    precise_mouse_move = mkHyprOption hyprTypes.bool;
  };
}
