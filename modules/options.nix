{lib, config, ...}: let
  inherit (hyprTypes) categoryToLua minimizeCategory;
  
  hyprTypes = import ./types.nix { inherit lib; };

  mkHyprOption = hyprTypes.mkHyprOption;

  cfg = config.nix-hyprland.config;
in {
  # v0.55.0
  options.nix-hyprland.config = {
    general = {
      border_size = mkHyprOption hyprTypes.int null;
      gaps_in = mkHyprOption hyprTypes.css_gaps null;
      gaps_out = mkHyprOption hyprTypes.css_gaps null;
      float_gaps = mkHyprOption hyprTypes.css_gaps null;
      gaps_workspaces = mkHyprOption hyprTypes.css_gaps null;
      col.inactive_border = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;
      col.active_border = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;
      col.nogroup_border = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;
      col.nogroup_border_active = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;
      layout = mkHyprOption hyprTypes.str null;
      no_focus_fallback = mkHyprOption hyprTypes.bool null;
      resize_on_border = mkHyprOption hyprTypes.bool null;
      extend_border_grab_area = mkHyprOption hyprTypes.int null;
      hover_icon_on_border = mkHyprOption hyprTypes.bool null;
      allow_tearing = mkHyprOption hyprTypes.bool null;
      resize_corner = mkHyprOption hyprTypes.int null;
      modal_parent_blocking = mkHyprOption hyprTypes.bool null;
      locale = mkHyprOption hyprTypes.str null;

      snap = {
        enabled = mkHyprOption hyprTypes.bool null;
        window_gap = mkHyprOption hyprTypes.int null;
        monitor_gap = mkHyprOption hyprTypes.int null;
        border_overlap = mkHyprOption hyprTypes.bool null;
        respect_gaps = mkHyprOption hyprTypes.bool null;
      };
    };

    decoration = {
      rounding = mkHyprOption hyprTypes.int null;
      rounding_power = mkHyprOption hyprTypes.float null;
      active_opacity = mkHyprOption hyprTypes.float null;
      inactive_opacity = mkHyprOption hyprTypes.float null;
      fullscreen_opacity = mkHyprOption hyprTypes.float null;
      dim_modal = mkHyprOption hyprTypes.bool null;
      dim_inactive = mkHyprOption hyprTypes.bool null;
      dim_strength = mkHyprOption hyprTypes.float null;
      dim_special = mkHyprOption hyprTypes.float null;
      dim_around = mkHyprOption hyprTypes.float null;
      screen_shader = mkHyprOption hyprTypes.str null;
      border_part_of_window = mkHyprOption hyprTypes.bool null;
      
      blur = {
        enabled = mkHyprOption hyprTypes.bool null;
        size = mkHyprOption hyprTypes.int null;
        passes = mkHyprOption hyprTypes.int null;
        ignore_opacity = mkHyprOption hyprTypes.bool null;
        new_optimizations = mkHyprOption hyprTypes.bool null;
        xray = mkHyprOption hyprTypes.bool null;
        noise = mkHyprOption hyprTypes.float null;
        contrast = mkHyprOption hyprTypes.float null;
        brightness = mkHyprOption hyprTypes.float null;
        vibrancy = mkHyprOption hyprTypes.float null;
        vibrancy_darkness = mkHyprOption hyprTypes.float null;
        special = mkHyprOption hyprTypes.bool null;
        popups = mkHyprOption hyprTypes.bool null;
        popups_ignorealpha = mkHyprOption hyprTypes.float null;
        input_methods = mkHyprOption hyprTypes.bool null;
        input_methods_ignorealpha = mkHyprOption hyprTypes.float null;
      };

      shadow = {
        enabled = mkHyprOption hyprTypes.bool null;
        range = mkHyprOption hyprTypes.int null;
        render_power = mkHyprOption hyprTypes.int null;
        sharp = mkHyprOption hyprTypes.bool null;
        color = mkHyprOption hyprTypes.color hyprTypes.color_toString;
        color_inactive = mkHyprOption hyprTypes.color hyprTypes.color_toString;
        offset = mkHyprOption hyprTypes.vec2 hyprTypes.vec2_toString;
        scale = mkHyprOption hyprTypes.float null;
      };

      glow = {
        enabled = mkHyprOption hyprTypes.bool null;
        range = mkHyprOption hyprTypes.int null;
        render_power = mkHyprOption hyprTypes.int null;
        color = mkHyprOption hyprTypes.color hyprTypes.color_toString;
        color_inactive = mkHyprOption hyprTypes.color hyprTypes.color_toString;
      };

      motion_blur = {
        enabled = mkHyprOption hyprTypes.bool null;
        samples = mkHyprOption hyprTypes.int null;
      };
    };

    animations = {
      enabled = mkHyprOption hyprTypes.bool null;
      workspace_wraparound = mkHyprOption hyprTypes.bool null;
    };

    input = {
      kb_model = mkHyprOption hyprTypes.str null;
      kb_layout = mkHyprOption hyprTypes.str null;
      kb_variant = mkHyprOption hyprTypes.str null;
      kb_options = mkHyprOption hyprTypes.str null;
      kb_rules = mkHyprOption hyprTypes.str null;
      kb_file = mkHyprOption hyprTypes.str null;
      numlock_by_default = mkHyprOption hyprTypes.bool null;
      resolve_binds_by_sym = mkHyprOption hyprTypes.bool null;
      repeat_rate = mkHyprOption hyprTypes.int null;
      repeat_delay = mkHyprOption hyprTypes.int null;
      sensitivity = mkHyprOption hyprTypes.float null;
      accel_profile = mkHyprOption hyprTypes.str null;
      force_no_accel = mkHyprOption hyprTypes.bool null;
      rotation = mkHyprOption hyprTypes.int null;
      left_handed = mkHyprOption hyprTypes.bool null;
      scroll_points = mkHyprOption hyprTypes.str null;
      scroll_method = mkHyprOption hyprTypes.str null;
      scroll_button = mkHyprOption hyprTypes.int null;
      scroll_button_lock = mkHyprOption hyprTypes.bool null;
      scroll_factor = mkHyprOption hyprTypes.float null;
      natural_scroll = mkHyprOption hyprTypes.bool null;
      follow_mouse = mkHyprOption hyprTypes.int null;
      follow_mouse_shrink = mkHyprOption hyprTypes.int null;
      follow_mouse_threshold = mkHyprOption hyprTypes.float null;
      focus_on_close = mkHyprOption hyprTypes.int null;
      mouse_refocus = mkHyprOption hyprTypes.bool null;
      float_switch_override_focus = mkHyprOption hyprTypes.int null;
      special_fallthrough = mkHyprOption hyprTypes.bool null;
      off_window_axis_events = mkHyprOption hyprTypes.int null;
      emulate_discrete_scroll = mkHyprOption hyprTypes.int null;

      touchpad = {
        disable_while_typing = mkHyprOption hyprTypes.bool null;
        natural_scroll = mkHyprOption hyprTypes.bool null;
        scroll_factor = mkHyprOption hyprTypes.float null;
        middle_button_emulation = mkHyprOption hyprTypes.bool null;
        tap_button_map = mkHyprOption hyprTypes.str null;
        clickfinger_behavior = mkHyprOption hyprTypes.bool null;
        tap_to_click = mkHyprOption hyprTypes.bool null;
        drag_lock = mkHyprOption hyprTypes.int null;
        tap_and_drag = mkHyprOption hyprTypes.bool null;
        flip_x = mkHyprOption hyprTypes.bool null;
        flip_y = mkHyprOption hyprTypes.bool null;
        drag_3fg = mkHyprOption hyprTypes.int null;
      };

      touchdevice = {
        transform = mkHyprOption hyprTypes.int null;
        output = mkHyprOption hyprTypes.string null;
        enabled = mkHyprOption hyprTypes.bool null;
      };

      virtualkeyboard = {
        share_states = mkHyprOption hyprTypes.int null;
        release_pressed_on_close = mkHyprOption hyprTypes.bool null;
      };

      tablet = {
        transform = mkHyprOption hyprTypes.int null;
        output = mkHyprOption hyprTypes.string null;
        region_position = mkHyprOption hyprTypes.vec2 hyprTypes.vec2_toString;
        absolute_region_position = mkHyprOption hyprTypes.bool null;
        region_size = mkHyprOption hyprTypes.vec2 hyprTypes.vec2_toString;
        relative_input = mkHyprOption hyprTypes.bool null;
        left_handed = mkHyprOption hyprTypes.bool null;
        active_area_size = mkHyprOption hyprTypes.vec2 hyprTypes.vec2_toString;
        active_area_position = mkHyprOption hyprTypes.vec2 hyprTypes.vec2_toString;
      };

      tablettool = {
        eraser_button_mode = mkHyprOption hyprTypes.int null;
        eraser_button_override = mkHyprOption hyprTypes.int null;
        pressure_range_min = mkHyprOption hyprTypes.float null;
        pressure_range_max = mkHyprOption hyprTypes.float null;
      };
    };

    gestures = {
      workspace_swipe_distance = mkHyprOption hyprTypes.int null;
      workspace_swipe_touch = mkHyprOption hyprTypes.bool null;
      workspace_swipe_invert = mkHyprOption hyprTypes.bool null;
      workspace_swipe_touch_invert = mkHyprOption hyprTypes.bool null;
      workspace_swipe_min_speed_to_force = mkHyprOption hyprTypes.int null;
      workspace_swipe_cancel_ratio = mkHyprOption hyprTypes.float null;
      workspace_swipe_create_new = mkHyprOption hyprTypes.bool null;
      workspace_swipe_direction_lock = mkHyprOption hyprTypes.bool null;
      workspace_swipe_direction_lock_threshold = mkHyprOption hyprTypes.int null;
      workspace_swipe_forever = mkHyprOption hyprTypes.bool null;
      workspace_swipe_use_r = mkHyprOption hyprTypes.bool null;
      close_max_timeout = mkHyprOption hyprTypes.int null;
    };

    group = {
      auto_group = mkHyprOption hyprTypes.bool null;
      insert_after_current = mkHyprOption hyprTypes.bool null;
      focus_removed_window = mkHyprOption hyprTypes.bool null;
      drag_into_group = mkHyprOption hyprTypes.int null;
      merge_groups_on_drag = mkHyprOption hyprTypes.bool null;
      merge_groups_on_groupbar = mkHyprOption hyprTypes.bool null;
      merge_floated_into_tiled_on_groupbar = mkHyprOption hyprTypes.bool null;
      group_on_movetoworkspace = mkHyprOption hyprTypes.bool null;
      col.border_active = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;
      col.border_inactive = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;
      col.border_locked_active = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;
      col.border_locked_inactive = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;

      groupbar = {
        enabled = mkHyprOption hyprTypes.bool null;
        font_family = mkHyprOption hyprTypes.string null;
        font_size = mkHyprOption hyprTypes.int null;
        font_weight_active = mkHyprOption hyprTypes.font_weight null;
        font_weight_inactive = mkHyprOption hyprTypes.font_weight null;
        gradients = mkHyprOption hyprTypes.bool null;
        height = mkHyprOption hyprTypes.int null;
        indicator_gap = mkHyprOption hyprTypes.int null;
        indicator_height = mkHyprOption hyprTypes.int null;
        stacked = mkHyprOption hyprTypes.bool null;
        priority = mkHyprOption hyprTypes.int null;
        render_titles = mkHyprOption hyprTypes.bool null;
        text_offset = mkHyprOption hyprTypes.int null;
        text_padding = mkHyprOption hyprTypes.int null;
        scrolling = mkHyprOption hyprTypes.bool null;
        rounding = mkHyprOption hyprTypes.int null;
        rounding_power = mkHyprOption hyprTypes.float null;
        gradient_rounding = mkHyprOption hyprTypes.int null;
        gradient_rounding_power = mkHyprOption hyprTypes.float null;
        round_only_edges = mkHyprOption hyprTypes.bool null;
        gradient_round_only_edges = mkHyprOption hyprTypes.bool null;
        text_color = mkHyprOption hyprTypes.color hyprTypes.color_toString;
        text_color_inactive = mkHyprOption hyprTypes.color hyprTypes.color_toString;
        text_color_locked_active = mkHyprOption hyprTypes.color hyprTypes.color_toString;
        text_color_locked_inactive = mkHyprOption hyprTypes.color hyprTypes.color_toString;
        col.active = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;
        col.inactive = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;
        col.locked_active = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;
        col.locked_inactive = mkHyprOption hyprTypes.gradient hyprTypes.gradient_toString;
        gaps_in = mkHyprOption hyprTypes.int null;
        gaps_out = mkHyprOption hyprTypes.int null;
        keep_upper_gap = mkHyprOption hyprTypes.bool null;
        middle_click_close = mkHyprOption hyprTypes.bool null;
        blur = mkHyprOption hyprTypes.bool null;
      };
    };

    misc = {
      disable_hyprland_logo = mkHyprOption hyprTypes.bool null;
      disable_splash_rendering = mkHyprOption hyprTypes.bool null;
      disable_scale_notification = mkHyprOption hyprTypes.bool null;
      col.splash = mkHyprOption hyprTypes.color hyprTypes.color_toString;
      font_family = mkHyprOption hyprTypes.string null;
      splash_font_family = mkHyprOption hyprTypes.string null;
      force_default_wallpaper = mkHyprOption hyprTypes.int null;
      vrr = mkHyprOption hyprTypes.int null;
      mouse_move_enables_dpms = mkHyprOption hyprTypes.bool null;
      key_press_enables_dpms = mkHyprOption hyprTypes.bool null;
      name_vk_after_proc = mkHyprOption hyprTypes.bool null;
      always_follow_on_dnd = mkHyprOption hyprTypes.bool null;
      layers_hog_keyboard_focus = mkHyprOption hyprTypes.bool null;
      animate_manual_resizes = mkHyprOption hyprTypes.bool null;
      animate_mouse_windowdragging = mkHyprOption hyprTypes.bool null;
      disable_autoreload = mkHyprOption hyprTypes.bool null;
      enable_swallow = mkHyprOption hyprTypes.bool null;
      swallow_regex = mkHyprOption hyprTypes.str null;
      swallow_exception_regex = mkHyprOption hyprTypes.str null;
      focus_on_activate = mkHyprOption hyprTypes.bool null;
      mouse_move_focuses_monitor = mkHyprOption hyprTypes.bool null;
      allow_session_lock_restore = mkHyprOption hyprTypes.bool null;
      session_lock_xray = mkHyprOption hyprTypes.bool null;
      background_color = mkHyprOption hyprTypes.color hyprTypes.color_toString;
      close_special_on_empty = mkHyprOption hyprTypes.bool null;
      on_focus_under_fullscreen = mkHyprOption hyprTypes.int null;
      exit_window_retains_fullscreen = mkHyprOption hyprTypes.bool null;
      initial_workspace_tracking = mkHyprOption hyprTypes.int null;
      middle_click_paste = mkHyprOption hyprTypes.bool null;
      render_unfocused_fps = mkHyprOption hyprTypes.int null;
      disable_xdg_env_checks = mkHyprOption hyprTypes.bool null;
      disable_hyprland_qtutils_check = mkHyprOption hyprTypes.bool null;
      lockdead_screen_delay = mkHyprOption hyprTypes.int null;
      enable_anr_dialog = mkHyprOption hyprTypes.bool null;
      anr_missed_pings = mkHyprOption hyprTypes.int null;
      size_limits_tiled = mkHyprOption hyprTypes.bool null;
      disable_watchdog_warning = mkHyprOption hyprTypes.bool null;
    };

    layout = {
      single_window_aspect_ratio = mkHyprOption hyprTypes.vec2 hyprTypes.vec2_toString;
      single_window_aspect_ratio_tolerance = mkHyprOption hyprTypes.int null;
    };

    binds = {
      pass_mouse_when_bound = mkHyprOption hyprTypes.bool null;
      scroll_event_delay = mkHyprOption hyprTypes.int null;
      workspace_back_and_forth = mkHyprOption hyprTypes.bool null;
      hide_special_on_workspace_change = mkHyprOption hyprTypes.bool null;
      allow_workspace_cycles = mkHyprOption hyprTypes.bool null;
      workspace_center_on = mkHyprOption hyprTypes.int null;
      focus_preferred_method = mkHyprOption hyprTypes.int null;
      ignore_group_lock = mkHyprOption hyprTypes.bool null;
      movefocus_cycles_fullscreen = mkHyprOption hyprTypes.bool null;
      movefocus_cycles_groupfirst = mkHyprOption hyprTypes.bool null;
      window_direction_monitor_fallback = mkHyprOption hyprTypes.bool null;
      disable_keybind_grabbing = mkHyprOption hyprTypes.bool null;
      allow_pin_fullscreen = mkHyprOption hyprTypes.bool null;
      drag_threshold = mkHyprOption hyprTypes.int null;
    };

    xwayland = {
      enabled = mkHyprOption hyprTypes.bool null;
      use_nearest_neighbor = mkHyprOption hyprTypes.bool null;
      force_zero_scaling = mkHyprOption hyprTypes.bool null;
      create_abstract_socket = mkHyprOption hyprTypes.bool null;
    };

    opengl = {
      nvidia_anti_flicker = mkHyprOption hyprTypes.bool null;
    };

    render = {
      direct_scanout = mkHyprOption hyprTypes.int null;
      expand_undersized_textures = mkHyprOption hyprTypes.bool null;
      xp_mode = mkHyprOption hyprTypes.bool null;
      ctm_animation = mkHyprOption hyprTypes.int null;
      cm_enabled = mkHyprOption hyprTypes.bool null;
      send_content_type = mkHyprOption hyprTypes.bool null;
      cm_auto_hdr = mkHyprOption hyprTypes.int null;
      new_render_scheduling = mkHyprOption hyprTypes.bool null;
      non_shader_cm = mkHyprOption hyprTypes.int null;
      non_shader_cm_interop = mkHyprOption hyprTypes.int null;
      cm_sdr_eotf = mkHyprOption hyprTypes.str null;
      commit_timing_enabled = mkHyprOption hyprTypes.bool null;
      use_fp16 = mkHyprOption hyprTypes.int null;
      keep_unmodified_copy = mkHyprOption hyprTypes.int null;
      use_shader_blur_blend = mkHyprOption hyprTypes.bool null;
    };

    cursor = {
      invisible = mkHyprOption hyprTypes.bool null;
      sync_gsettings_theme = mkHyprOption hyprTypes.bool null;
      no_hardware_cursors = mkHyprOption hyprTypes.int null;
      no_break_fs_vrr = mkHyprOption hyprTypes.int null;
      min_refresh_rate = mkHyprOption hyprTypes.int null;
      hotspot_padding = mkHyprOption hyprTypes.int null;
      inactive_timeout = mkHyprOption hyprTypes.float null;
      no_warps = mkHyprOption hyprTypes.bool null;
      persistent_warps = mkHyprOption hyprTypes.bool null;
      warp_on_change_workspace = mkHyprOption hyprTypes.int null;
      warp_on_toggle_special = mkHyprOption hyprTypes.int null;
      default_monitor = mkHyprOption hyprTypes.str null;
      zoom_factor = mkHyprOption hyprTypes.float null;
      zoom_rigid = mkHyprOption hyprTypes.bool null;
      zoom_detached_camera = mkHyprOption hyprTypes.bool null;
      enable_hyprcursor = mkHyprOption hyprTypes.bool null;
      hide_on_key_press = mkHyprOption hyprTypes.bool null;
      hide_on_touch = mkHyprOption hyprTypes.bool null;
      hide_on_tablet = mkHyprOption hyprTypes.bool null;
      use_cpu_buffer = mkHyprOption hyprTypes.int null;
      warp_back_after_non_mouse_input = mkHyprOption hyprTypes.bool null;
      zoom_disable_aa = mkHyprOption hyprTypes.bool null;
    };

    ecosystem = {
      no_update_news = mkHyprOption hyprTypes.bool null;
      no_donation_nag = mkHyprOption hyprTypes.bool null;
      enforce_permissions = mkHyprOption hyprTypes.bool null;
    };

    quirks = {
      prefer_hdr = mkHyprOption hyprTypes.int null;
    };

    debug = {
      overlay = mkHyprOption hyprTypes.bool null;
      damage_blink = mkHyprOption hyprTypes.bool null;
      gl_debugging = mkHyprOption hyprTypes.bool null;
      vfr = mkHyprOption hyprTypes.bool null;
      disable_logs = mkHyprOption hyprTypes.bool null;
      disable_time = mkHyprOption hyprTypes.bool null;
      damage_tracking = mkHyprOption hyprTypes.int null;
      enable_stdout_logs = mkHyprOption hyprTypes.bool null;
      manual_crash = mkHyprOption hyprTypes.int null;
      suppress_errors = mkHyprOption hyprTypes.bool null;
      watchdog_timeout = mkHyprOption hyprTypes.int null;
      disable_scale_checks = mkHyprOption hyprTypes.bool null;
      error_limit = mkHyprOption hyprTypes.int null;
      error_position = mkHyprOption hyprTypes.int null;
      colored_stdout_logs = mkHyprOption hyprTypes.bool null;
      pass = mkHyprOption hyprTypes.bool null;
      full_cm_proto = mkHyprOption hyprTypes.bool null;
      invalidate_fp16 = mkHyprOption hyprTypes.int null;
    };
  };

  config = {
    # TODO Home manager
    environment.etc."hyprland.lua".text = ''
      hl.config(${categoryToLua (minimizeCategory cfg)})
    '';
  };
}
