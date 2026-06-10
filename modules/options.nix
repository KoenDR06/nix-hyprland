{ hyprLib, lib, config, ... }: let
  hyprTypes = hyprLib.types;
  mkHyprOption = hyprTypes.mkHyprOption;
in {
  # v0.55.0
  options.hypr.config = {
    general = {
      border_size = mkHyprOption hyprTypes.int;
      gaps_in = mkHyprOption hyprTypes.css_gaps;
      gaps_out = mkHyprOption hyprTypes.css_gaps;
      float_gaps = mkHyprOption hyprTypes.css_gaps;
      gaps_workspaces = mkHyprOption hyprTypes.css_gaps;
      col.inactive_border = mkHyprOption hyprTypes.gradient;
      col.active_border = mkHyprOption hyprTypes.gradient;
      col.nogroup_border = mkHyprOption hyprTypes.gradient;
      col.nogroup_border_active = mkHyprOption hyprTypes.gradient;
      layout = mkHyprOption hyprTypes.str;
      no_focus_fallback = mkHyprOption hyprTypes.bool;
      resize_on_border = mkHyprOption hyprTypes.bool;
      extend_border_grab_area = mkHyprOption hyprTypes.int;
      hover_icon_on_border = mkHyprOption hyprTypes.bool;
      allow_tearing = mkHyprOption hyprTypes.bool;
      resize_corner = mkHyprOption hyprTypes.int;
      modal_parent_blocking = mkHyprOption hyprTypes.bool;
      locale = mkHyprOption hyprTypes.str;

      snap = {
        enabled = mkHyprOption hyprTypes.bool;
        window_gap = mkHyprOption hyprTypes.int;
        monitor_gap = mkHyprOption hyprTypes.int;
        border_overlap = mkHyprOption hyprTypes.bool;
        respect_gaps = mkHyprOption hyprTypes.bool;
      };
    };

    decoration = {
      rounding = mkHyprOption hyprTypes.int;
      rounding_power = mkHyprOption hyprTypes.float;
      active_opacity = mkHyprOption hyprTypes.float;
      inactive_opacity = mkHyprOption hyprTypes.float;
      fullscreen_opacity = mkHyprOption hyprTypes.float;
      dim_modal = mkHyprOption hyprTypes.bool;
      dim_inactive = mkHyprOption hyprTypes.bool;
      dim_strength = mkHyprOption hyprTypes.float;
      dim_special = mkHyprOption hyprTypes.float;
      dim_around = mkHyprOption hyprTypes.float;
      screen_shader = mkHyprOption hyprTypes.str;
      border_part_of_window = mkHyprOption hyprTypes.bool;
      
      blur = {
        enabled = mkHyprOption hyprTypes.bool;
        size = mkHyprOption hyprTypes.int;
        passes = mkHyprOption hyprTypes.int;
        ignore_opacity = mkHyprOption hyprTypes.bool;
        new_optimizations = mkHyprOption hyprTypes.bool;
        xray = mkHyprOption hyprTypes.bool;
        noise = mkHyprOption hyprTypes.float;
        contrast = mkHyprOption hyprTypes.float;
        brightness = mkHyprOption hyprTypes.float;
        vibrancy = mkHyprOption hyprTypes.float;
        vibrancy_darkness = mkHyprOption hyprTypes.float;
        special = mkHyprOption hyprTypes.bool;
        popups = mkHyprOption hyprTypes.bool;
        popups_ignorealpha = mkHyprOption hyprTypes.float;
        input_methods = mkHyprOption hyprTypes.bool;
        input_methods_ignorealpha = mkHyprOption hyprTypes.float;
      };

      shadow = {
        enabled = mkHyprOption hyprTypes.bool;
        range = mkHyprOption hyprTypes.int;
        render_power = mkHyprOption hyprTypes.int;
        sharp = mkHyprOption hyprTypes.bool;
        color = mkHyprOption hyprTypes.color;
        color_inactive = mkHyprOption hyprTypes.color;
        offset = mkHyprOption hyprTypes.vec2;
        scale = mkHyprOption hyprTypes.float;
      };

      glow = {
        enabled = mkHyprOption hyprTypes.bool;
        range = mkHyprOption hyprTypes.int;
        render_power = mkHyprOption hyprTypes.int;
        color = mkHyprOption hyprTypes.color;
        color_inactive = mkHyprOption hyprTypes.color;
      };

      motion_blur = {
        enabled = mkHyprOption hyprTypes.bool;
        samples = mkHyprOption hyprTypes.int;
      };
    };

    animations = {
      enabled = mkHyprOption hyprTypes.bool;
      workspace_wraparound = mkHyprOption hyprTypes.bool;
    };

    input = {
      kb_model = mkHyprOption hyprTypes.str;
      kb_layout = mkHyprOption hyprTypes.str;
      kb_variant = mkHyprOption hyprTypes.str;
      kb_options = mkHyprOption hyprTypes.str;
      kb_rules = mkHyprOption hyprTypes.str;
      kb_file = mkHyprOption hyprTypes.str;
      numlock_by_default = mkHyprOption hyprTypes.bool;
      resolve_binds_by_sym = mkHyprOption hyprTypes.bool;
      repeat_rate = mkHyprOption hyprTypes.int;
      repeat_delay = mkHyprOption hyprTypes.int;
      sensitivity = mkHyprOption hyprTypes.float;
      accel_profile = mkHyprOption hyprTypes.str;
      force_no_accel = mkHyprOption hyprTypes.bool;
      rotation = mkHyprOption hyprTypes.int;
      left_handed = mkHyprOption hyprTypes.bool;
      scroll_points = mkHyprOption hyprTypes.str;
      scroll_method = mkHyprOption hyprTypes.str;
      scroll_button = mkHyprOption hyprTypes.int;
      scroll_button_lock = mkHyprOption hyprTypes.bool;
      scroll_factor = mkHyprOption hyprTypes.float;
      natural_scroll = mkHyprOption hyprTypes.bool;
      follow_mouse = mkHyprOption hyprTypes.int;
      follow_mouse_shrink = mkHyprOption hyprTypes.int;
      follow_mouse_threshold = mkHyprOption hyprTypes.float;
      focus_on_close = mkHyprOption hyprTypes.int;
      mouse_refocus = mkHyprOption hyprTypes.bool;
      float_switch_override_focus = mkHyprOption hyprTypes.int;
      special_fallthrough = mkHyprOption hyprTypes.bool;
      off_window_axis_events = mkHyprOption hyprTypes.int;
      emulate_discrete_scroll = mkHyprOption hyprTypes.int;

      touchpad = {
        disable_while_typing = mkHyprOption hyprTypes.bool;
        natural_scroll = mkHyprOption hyprTypes.bool;
        scroll_factor = mkHyprOption hyprTypes.float;
        middle_button_emulation = mkHyprOption hyprTypes.bool;
        tap_button_map = mkHyprOption hyprTypes.str;
        clickfinger_behavior = mkHyprOption hyprTypes.bool;
        tap_to_click = mkHyprOption hyprTypes.bool;
        drag_lock = mkHyprOption hyprTypes.int;
        tap_and_drag = mkHyprOption hyprTypes.bool;
        flip_x = mkHyprOption hyprTypes.bool;
        flip_y = mkHyprOption hyprTypes.bool;
        drag_3fg = mkHyprOption hyprTypes.int;
      };

      touchdevice = {
        transform = mkHyprOption hyprTypes.int;
        output = mkHyprOption hyprTypes.str;
        enabled = mkHyprOption hyprTypes.bool;
      };

      virtualkeyboard = {
        share_states = mkHyprOption hyprTypes.int;
        release_pressed_on_close = mkHyprOption hyprTypes.bool;
      };

      tablet = {
        transform = mkHyprOption hyprTypes.int;
        output = mkHyprOption hyprTypes.str;
        region_position = mkHyprOption hyprTypes.vec2;
        absolute_region_position = mkHyprOption hyprTypes.bool;
        region_size = mkHyprOption hyprTypes.vec2;
        relative_input = mkHyprOption hyprTypes.bool;
        left_handed = mkHyprOption hyprTypes.bool;
        active_area_size = mkHyprOption hyprTypes.vec2;
        active_area_position = mkHyprOption hyprTypes.vec2;
      };

      tablettool = {
        eraser_button_mode = mkHyprOption hyprTypes.int;
        eraser_button_override = mkHyprOption hyprTypes.int;
        pressure_range_min = mkHyprOption hyprTypes.float;
        pressure_range_max = mkHyprOption hyprTypes.float;
      };
    };

    gestures = {
      workspace_swipe_distance = mkHyprOption hyprTypes.int;
      workspace_swipe_touch = mkHyprOption hyprTypes.bool;
      workspace_swipe_invert = mkHyprOption hyprTypes.bool;
      workspace_swipe_touch_invert = mkHyprOption hyprTypes.bool;
      workspace_swipe_min_speed_to_force = mkHyprOption hyprTypes.int;
      workspace_swipe_cancel_ratio = mkHyprOption hyprTypes.float;
      workspace_swipe_create_new = mkHyprOption hyprTypes.bool;
      workspace_swipe_direction_lock = mkHyprOption hyprTypes.bool;
      workspace_swipe_direction_lock_threshold = mkHyprOption hyprTypes.int;
      workspace_swipe_forever = mkHyprOption hyprTypes.bool;
      workspace_swipe_use_r = mkHyprOption hyprTypes.bool;
      close_max_timeout = mkHyprOption hyprTypes.int;
    };

    group = {
      auto_group = mkHyprOption hyprTypes.bool;
      insert_after_current = mkHyprOption hyprTypes.bool;
      focus_removed_window = mkHyprOption hyprTypes.bool;
      drag_into_group = mkHyprOption hyprTypes.int;
      merge_groups_on_drag = mkHyprOption hyprTypes.bool;
      merge_groups_on_groupbar = mkHyprOption hyprTypes.bool;
      merge_floated_into_tiled_on_groupbar = mkHyprOption hyprTypes.bool;
      group_on_movetoworkspace = mkHyprOption hyprTypes.bool;
      col.border_active = mkHyprOption hyprTypes.gradient;
      col.border_inactive = mkHyprOption hyprTypes.gradient;
      col.border_locked_active = mkHyprOption hyprTypes.gradient;
      col.border_locked_inactive = mkHyprOption hyprTypes.gradient;

      groupbar = {
        enabled = mkHyprOption hyprTypes.bool;
        font_family = mkHyprOption hyprTypes.str;
        font_size = mkHyprOption hyprTypes.int;
        font_weight_active = mkHyprOption hyprTypes.font_weight;
        font_weight_inactive = mkHyprOption hyprTypes.font_weight;
        gradients = mkHyprOption hyprTypes.bool;
        height = mkHyprOption hyprTypes.int;
        indicator_gap = mkHyprOption hyprTypes.int;
        indicator_height = mkHyprOption hyprTypes.int;
        stacked = mkHyprOption hyprTypes.bool;
        priority = mkHyprOption hyprTypes.int;
        render_titles = mkHyprOption hyprTypes.bool;
        text_offset = mkHyprOption hyprTypes.int;
        text_padding = mkHyprOption hyprTypes.int;
        scrolling = mkHyprOption hyprTypes.bool;
        rounding = mkHyprOption hyprTypes.int;
        rounding_power = mkHyprOption hyprTypes.float;
        gradient_rounding = mkHyprOption hyprTypes.int;
        gradient_rounding_power = mkHyprOption hyprTypes.float;
        round_only_edges = mkHyprOption hyprTypes.bool;
        gradient_round_only_edges = mkHyprOption hyprTypes.bool;
        text_color = mkHyprOption hyprTypes.color;
        text_color_inactive = mkHyprOption hyprTypes.color;
        text_color_locked_active = mkHyprOption hyprTypes.color;
        text_color_locked_inactive = mkHyprOption hyprTypes.color;
        col.active = mkHyprOption hyprTypes.gradient;
        col.inactive = mkHyprOption hyprTypes.gradient;
        col.locked_active = mkHyprOption hyprTypes.gradient;
        col.locked_inactive = mkHyprOption hyprTypes.gradient;
        gaps_in = mkHyprOption hyprTypes.int;
        gaps_out = mkHyprOption hyprTypes.int;
        keep_upper_gap = mkHyprOption hyprTypes.bool;
        middle_click_close = mkHyprOption hyprTypes.bool;
        blur = mkHyprOption hyprTypes.bool;
      };
    };

    misc = {
      disable_hyprland_logo = mkHyprOption hyprTypes.bool;
      disable_splash_rendering = mkHyprOption hyprTypes.bool;
      disable_scale_notification = mkHyprOption hyprTypes.bool;
      col.splash = mkHyprOption hyprTypes.color;
      font_family = mkHyprOption hyprTypes.str;
      splash_font_family = mkHyprOption hyprTypes.str;
      force_default_wallpaper = mkHyprOption hyprTypes.int;
      vrr = mkHyprOption hyprTypes.int;
      mouse_move_enables_dpms = mkHyprOption hyprTypes.bool;
      key_press_enables_dpms = mkHyprOption hyprTypes.bool;
      name_vk_after_proc = mkHyprOption hyprTypes.bool;
      always_follow_on_dnd = mkHyprOption hyprTypes.bool;
      layers_hog_keyboard_focus = mkHyprOption hyprTypes.bool;
      animate_manual_resizes = mkHyprOption hyprTypes.bool;
      animate_mouse_windowdragging = mkHyprOption hyprTypes.bool;
      disable_autoreload = mkHyprOption hyprTypes.bool;
      enable_swallow = mkHyprOption hyprTypes.bool;
      swallow_regex = mkHyprOption hyprTypes.str;
      swallow_exception_regex = mkHyprOption hyprTypes.str;
      focus_on_activate = mkHyprOption hyprTypes.bool;
      mouse_move_focuses_monitor = mkHyprOption hyprTypes.bool;
      allow_session_lock_restore = mkHyprOption hyprTypes.bool;
      session_lock_xray = mkHyprOption hyprTypes.bool;
      background_color = mkHyprOption hyprTypes.color;
      close_special_on_empty = mkHyprOption hyprTypes.bool;
      on_focus_under_fullscreen = mkHyprOption hyprTypes.int;
      exit_window_retains_fullscreen = mkHyprOption hyprTypes.bool;
      initial_workspace_tracking = mkHyprOption hyprTypes.int;
      middle_click_paste = mkHyprOption hyprTypes.bool;
      render_unfocused_fps = mkHyprOption hyprTypes.int;
      disable_xdg_env_checks = mkHyprOption hyprTypes.bool;
      disable_hyprland_qtutils_check = mkHyprOption hyprTypes.bool;
      lockdead_screen_delay = mkHyprOption hyprTypes.int;
      enable_anr_dialog = mkHyprOption hyprTypes.bool;
      anr_missed_pings = mkHyprOption hyprTypes.int;
      size_limits_tiled = mkHyprOption hyprTypes.bool;
      disable_watchdog_warning = mkHyprOption hyprTypes.bool;
    };

    layout = {
      single_window_aspect_ratio = mkHyprOption hyprTypes.vec2;
      single_window_aspect_ratio_tolerance = mkHyprOption hyprTypes.int;
    };

    binds = {
      pass_mouse_when_bound = mkHyprOption hyprTypes.bool;
      scroll_event_delay = mkHyprOption hyprTypes.int;
      workspace_back_and_forth = mkHyprOption hyprTypes.bool;
      hide_special_on_workspace_change = mkHyprOption hyprTypes.bool;
      allow_workspace_cycles = mkHyprOption hyprTypes.bool;
      workspace_center_on = mkHyprOption hyprTypes.int;
      focus_preferred_method = mkHyprOption hyprTypes.int;
      ignore_group_lock = mkHyprOption hyprTypes.bool;
      movefocus_cycles_fullscreen = mkHyprOption hyprTypes.bool;
      movefocus_cycles_groupfirst = mkHyprOption hyprTypes.bool;
      window_direction_monitor_fallback = mkHyprOption hyprTypes.bool;
      disable_keybind_grabbing = mkHyprOption hyprTypes.bool;
      allow_pin_fullscreen = mkHyprOption hyprTypes.bool;
      drag_threshold = mkHyprOption hyprTypes.int;
    };

    xwayland = {
      enabled = mkHyprOption hyprTypes.bool;
      use_nearest_neighbor = mkHyprOption hyprTypes.bool;
      force_zero_scaling = mkHyprOption hyprTypes.bool;
      create_abstract_socket = mkHyprOption hyprTypes.bool;
    };

    opengl = {
      nvidia_anti_flicker = mkHyprOption hyprTypes.bool;
    };

    render = {
      direct_scanout = mkHyprOption hyprTypes.int;
      expand_undersized_textures = mkHyprOption hyprTypes.bool;
      xp_mode = mkHyprOption hyprTypes.bool;
      ctm_animation = mkHyprOption hyprTypes.int;
      cm_enabled = mkHyprOption hyprTypes.bool;
      send_content_type = mkHyprOption hyprTypes.bool;
      cm_auto_hdr = mkHyprOption hyprTypes.int;
      new_render_scheduling = mkHyprOption hyprTypes.bool;
      non_shader_cm = mkHyprOption hyprTypes.int;
      non_shader_cm_interop = mkHyprOption hyprTypes.int;
      cm_sdr_eotf = mkHyprOption hyprTypes.str;
      commit_timing_enabled = mkHyprOption hyprTypes.bool;
      use_fp16 = mkHyprOption hyprTypes.int;
      keep_unmodified_copy = mkHyprOption hyprTypes.int;
      use_shader_blur_blend = mkHyprOption hyprTypes.bool;
    };

    cursor = {
      invisible = mkHyprOption hyprTypes.bool;
      sync_gsettings_theme = mkHyprOption hyprTypes.bool;
      no_hardware_cursors = mkHyprOption hyprTypes.int;
      no_break_fs_vrr = mkHyprOption hyprTypes.int;
      min_refresh_rate = mkHyprOption hyprTypes.int;
      hotspot_padding = mkHyprOption hyprTypes.int;
      inactive_timeout = mkHyprOption hyprTypes.float;
      no_warps = mkHyprOption hyprTypes.bool;
      persistent_warps = mkHyprOption hyprTypes.bool;
      warp_on_change_workspace = mkHyprOption hyprTypes.int;
      warp_on_toggle_special = mkHyprOption hyprTypes.int;
      default_monitor = mkHyprOption hyprTypes.str;
      zoom_factor = mkHyprOption hyprTypes.float;
      zoom_rigid = mkHyprOption hyprTypes.bool;
      zoom_detached_camera = mkHyprOption hyprTypes.bool;
      enable_hyprcursor = mkHyprOption hyprTypes.bool;
      hide_on_key_press = mkHyprOption hyprTypes.bool;
      hide_on_touch = mkHyprOption hyprTypes.bool;
      hide_on_tablet = mkHyprOption hyprTypes.bool;
      use_cpu_buffer = mkHyprOption hyprTypes.int;
      warp_back_after_non_mouse_input = mkHyprOption hyprTypes.bool;
      zoom_disable_aa = mkHyprOption hyprTypes.bool;
    };

    ecosystem = {
      no_update_news = mkHyprOption hyprTypes.bool;
      no_donation_nag = mkHyprOption hyprTypes.bool;
      enforce_permissions = mkHyprOption hyprTypes.bool;
    };

    quirks = {
      prefer_hdr = mkHyprOption hyprTypes.int;
    };

    debug = {
      overlay = mkHyprOption hyprTypes.bool;
      damage_blink = mkHyprOption hyprTypes.bool;
      gl_debugging = mkHyprOption hyprTypes.bool;
      vfr = mkHyprOption hyprTypes.bool;
      disable_logs = mkHyprOption hyprTypes.bool;
      disable_time = mkHyprOption hyprTypes.bool;
      damage_tracking = mkHyprOption hyprTypes.int;
      enable_stdout_logs = mkHyprOption hyprTypes.bool;
      manual_crash = mkHyprOption hyprTypes.int;
      suppress_errors = mkHyprOption hyprTypes.bool;
      watchdog_timeout = mkHyprOption hyprTypes.int;
      disable_scale_checks = mkHyprOption hyprTypes.bool;
      error_limit = mkHyprOption hyprTypes.int;
      error_position = mkHyprOption hyprTypes.int;
      colored_stdout_logs = mkHyprOption hyprTypes.bool;
      pass = mkHyprOption hyprTypes.bool;
      full_cm_proto = mkHyprOption hyprTypes.bool;
      invalidate_fp16 = mkHyprOption hyprTypes.int;
    };
  };
}
