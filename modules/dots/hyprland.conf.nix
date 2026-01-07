{
  lib,
  config,
  ...
}: let
  inherit (lib) types mkIf trivial strings mkOption;
  inherit (builtins) concatStringsSep genList elemAt length;
  inherit (trivial) boolToString;
  inherit (strings) floatToString;

  cfg = config.nix-hyprland.dots.hyprland;
  username = config.horseman.username;
  hypr = config.nix-hyprland;
in {
  options = {
    nix-hyprland.dots.hyprland = {
      enable = mkOption {
        default = true;
        type = types.bool;
      };
    };
  };

  config = mkIf (cfg.enable && cfg.enable) {
    home-manager.users.${username}.xdg.configFile."hypr/hyprland.conf".text = ''
      ${concatStringsSep "\n" (map toString hypr.keybindings.binds)}

      ${concatStringsSep "\n" (map toString hypr.gestures.gestures)}

      ${concatStringsSep "\n" (map toString hypr.keybindings.submaps)}

      ${concatStringsSep "\n" (map (x: "exec-once = " + x) hypr.execOnce)}

      ${concatStringsSep "\n" (map (x: "env = ${x.name},${x.value}") hypr.env)}

      general {
          border_size = ${toString hypr.general.borderSize}
          gaps_in = ${toString hypr.general.gapsIn}
          gaps_out = ${toString hypr.general.gapsOut}
          gaps_workspaces = ${toString hypr.general.gapsWorkspaces}
          col.inactive_border = ${hypr.general.col.inactiveBorder}
          col.active_border = ${hypr.general.col.activeBorder}
          col.nogroup_border = ${hypr.general.col.nogroupBorder}
          col.nogroup_border_active = ${hypr.general.col.nogroupBorderActive}
          layout = ${hypr.general.layout}
          no_focus_fallback = ${boolToString hypr.general.noFocusFallback}
          resize_on_border = ${boolToString hypr.general.resizeOnBorder}
          extend_border_grab_area = ${toString hypr.general.extendBorderGrabArea}
          hover_icon_on_border = ${boolToString hypr.general.hoverIconOnBorder}
          allow_tearing = ${boolToString hypr.general.allowTearing}
          resize_corner = ${toString hypr.general.resizeCorner}

          snap {
              enabled = ${boolToString hypr.general.snap.enabled}
              window_gap = ${toString hypr.general.snap.windowGap}
              monitor_gap = ${toString hypr.general.snap.monitorGap}
              border_overlap = ${boolToString hypr.general.snap.borderOverlap}
          }
      }

      decoration {
          rounding = ${toString hypr.decoration.rounding}
          rounding_power = ${toString hypr.decoration.roundingPower}
          active_opacity = ${toString hypr.decoration.activeOpacity}
          inactive_opacity = ${toString hypr.decoration.inactiveOpacity}
          fullscreen_opacity = ${toString hypr.decoration.fullscreenOpacity}
          dim_inactive = ${boolToString hypr.decoration.dimInactive}
          dim_strength = ${toString hypr.decoration.dimStrength}
          dim_special = ${toString hypr.decoration.dimSpecial}
          dim_around = ${toString hypr.decoration.dimAround}
          screen_shader = ${toString hypr.decoration.screenShader}
          border_part_of_window = ${boolToString hypr.decoration.borderPartOfWindow}

          blur {
              enabled = ${boolToString hypr.decoration.blur.enabled}
              size = ${toString hypr.decoration.blur.size}
              passes = ${toString hypr.decoration.blur.passes}
              ignore_opacity = ${boolToString hypr.decoration.blur.ignoreOpacity}
              new_optimizations = ${boolToString hypr.decoration.blur.newOptimizations}
              xray = ${boolToString hypr.decoration.blur.xray}
              noise = ${toString hypr.decoration.blur.noise}
              contrast = ${toString hypr.decoration.blur.contrast}
              brightness = ${toString hypr.decoration.blur.brightness}
              vibrancy = ${toString hypr.decoration.blur.vibrancy}
              vibrancy_darkness = ${toString hypr.decoration.blur.vibrancyDarkness}
              special = ${boolToString hypr.decoration.blur.special}
              popups = ${boolToString hypr.decoration.blur.popups}
              popups_ignorealpha = ${toString hypr.decoration.blur.popupsIgnorealpha}
              input_methods = ${boolToString hypr.decoration.blur.inputMethods}
              input_methods_ignorealpha = ${toString hypr.decoration.blur.inputMethodsIgnorealpha}
          }

          shadow {
              enabled = ${boolToString hypr.decoration.shadow.enabled}
              range = ${toString hypr.decoration.shadow.range}
              render_power = ${toString hypr.decoration.shadow.renderPower}
              sharp = ${boolToString hypr.decoration.shadow.sharp}
              ignore_window = ${boolToString hypr.decoration.shadow.ignoreWindow}
              color = ${toString hypr.decoration.shadow.color}
              ${
        if (hypr.decoration.shadow.colorInactive == null)
        then ""
        else "color_inactive = ${toString hypr.decoration.shadow.colorInactive}"
      }
              offset = ${toString hypr.decoration.shadow.offset.x} ${toString hypr.decoration.shadow.offset.y}
              scale = ${toString hypr.decoration.shadow.scale}
          }
      }

      animations {
          enabled = ${boolToString hypr.animations.enabled}
          workspace_wraparound = ${boolToString hypr.animations.workspaceWraparound}

          ${concatStringsSep "\n    " (map toString hypr.animations.beziers)}

          ${concatStringsSep "\n    " (map toString hypr.animations.animations)}
      }

      input {
          kb_model = ${toString hypr.input.kbModel}
          kb_layout = ${toString hypr.input.kbLayout}
          kb_variant = ${toString hypr.input.kbVariant}
          kb_options = ${toString hypr.input.kbOptions}
          kb_rules = ${toString hypr.input.kbRules}
          kb_file = ${toString hypr.input.kbFile}
          numlock_by_default = ${boolToString hypr.input.numlockByDefault}
          resolve_binds_by_sym = ${boolToString hypr.input.resolveBindsBySym}
          repeat_rate = ${toString hypr.input.repeatRate}
          repeat_delay = ${toString hypr.input.repeatDelay}
          sensitivity = ${toString hypr.input.sensitivity}
          accel_profile = ${toString hypr.input.accelProfile}
          force_no_accel = ${boolToString hypr.input.forceNoAccel}
          left_handed = ${boolToString hypr.input.leftHanded}
          scroll_points = ${toString hypr.input.scrollPoints}
          scroll_method = ${toString hypr.input.scrollMethod}
          scroll_button = ${toString hypr.input.scrollButton}
          scroll_button_lock = ${boolToString hypr.input.scrollButtonLock}
          scroll_factor = ${toString hypr.input.scrollFactor}
          natural_scroll = ${boolToString hypr.input.naturalScroll}
          follow_mouse = ${toString hypr.input.followMouse}
          follow_mouse_threshold = ${toString hypr.input.followMouseThreshold}
          focus_on_close = ${toString hypr.input.focusOnClose}
          mouse_refocus = ${boolToString hypr.input.mouseRefocus}
          float_switch_override_focus = ${toString hypr.input.floatSwitchOverrideFocus}
          special_fallthrough = ${boolToString hypr.input.specialFallthrough}
          off_window_axis_events = ${toString hypr.input.offWindowAxisEvents}
          emulate_discrete_scroll = ${toString hypr.input.emulateDiscreteScroll}

          touchpad {
              disable_while_typing = ${boolToString hypr.input.touchpad.disableWhileTyping}
              natural_scroll = ${boolToString hypr.input.touchpad.naturalScroll}
              scroll_factor = ${toString hypr.input.touchpad.scrollFactor}
              middle_button_emulation = ${boolToString hypr.input.touchpad.middleButtonEmulation}
              tap_button_map = ${toString hypr.input.touchpad.tapButtonMap}
              clickfinger_behavior = ${boolToString hypr.input.touchpad.clickfingerBehavior}
              tap-to-click = ${boolToString hypr.input.touchpad.tapToClick}
              drag_lock = ${toString hypr.input.touchpad.dragLock}
              tap-and-drag = ${toString hypr.input.touchpad.tapAndDrag}
              flip_x = ${boolToString hypr.input.touchpad.flipX}
              flip_y = ${boolToString hypr.input.touchpad.flipY}
          }

          touchdevice {
              transform = ${toString hypr.input.touchdevice.transform}
              output = ${toString hypr.input.touchdevice.output}
              enabled = ${boolToString hypr.input.touchdevice.enabled}
          }

          tablet {
              transform = ${toString hypr.input.tablet.transform}
              output = ${toString hypr.input.tablet.output}
              region_position = ${toString hypr.input.tablet.regionPosition.x} ${toString hypr.input.tablet.regionPosition.y}
              absolute_region_position = ${boolToString hypr.input.tablet.absoluteRegionPosition}
              region_size = ${toString hypr.input.tablet.regionSize.x} ${toString hypr.input.tablet.regionSize.y}
              relative_input = ${boolToString hypr.input.tablet.relativeInput}
              left_handed = ${boolToString hypr.input.tablet.leftHanded}
              active_area_size = ${toString hypr.input.tablet.activeAreaSize.x} ${toString hypr.input.tablet.activeAreaSize.y}
              active_area_position = ${toString hypr.input.tablet.activeAreaPosition.x} ${toString hypr.input.tablet.activeAreaPosition.y}
          }
      }

      gestures {
          workspace_swipe_distance = ${toString hypr.gestures.workspaceSwipeDistance}
          workspace_swipe_touch = ${boolToString hypr.gestures.workspaceSwipeTouch}
          workspace_swipe_invert = ${boolToString hypr.gestures.workspaceSwipeInvert}
          workspace_swipe_touch_invert = ${boolToString hypr.gestures.workspaceSwipeTouchInvert}
          workspace_swipe_min_speed_to_force = ${toString hypr.gestures.workspaceSwipeMinSpeedToForce}
          workspace_swipe_cancel_ratio = ${floatToString hypr.gestures.workspaceSwipeCancelRatio}
          workspace_swipe_create_new = ${boolToString hypr.gestures.workspaceSwipeCreateNew}
          workspace_swipe_direction_lock = ${boolToString hypr.gestures.workspaceSwipeDirectionLock}
          workspace_swipe_direction_lock_threshold = ${toString hypr.gestures.workspaceSwipeDirectionLockThreshold}
          workspace_swipe_forever = ${boolToString hypr.gestures.workspaceSwipeForever}
          workspace_swipe_use_r = ${boolToString hypr.gestures.workspaceSwipeUseR}
      }

      group {
          auto_group = ${boolToString hypr.group.autoGroup}
          insert_after_current = ${boolToString hypr.group.insertAfterCurrent}
          focus_removed_window = ${boolToString hypr.group.focusRemovedWindow}
          drag_into_group = ${toString hypr.group.dragIntoGroup}
          merge_groups_on_drag = ${boolToString hypr.group.mergeGroupsOnDrag}
          merge_groups_on_groupbar = ${boolToString hypr.group.mergeGroupsOnGroupbar}
          merge_floated_into_tiled_on_groupbar = ${boolToString hypr.group.mergeFloatedIntoTiledOnGroupbar}
          group_on_movetoworkspace = ${boolToString hypr.group.groupOnMovetoworkspace}
          col.border_active = ${toString hypr.group.col.borderActive}
          col.border_inactive = ${toString hypr.group.col.borderInactive}
          col.border_locked_active = ${toString hypr.group.col.borderLockedActive}
          col.border_locked_inactive = ${toString hypr.group.col.borderLockedInactive}

          groupbar {
              enabled = ${boolToString hypr.group.groupbar.enabled}
              font_family = ${toString hypr.group.groupbar.fontFamily}
              font_size = ${toString hypr.group.groupbar.fontSize}
              font_weight_active = ${toString hypr.group.groupbar.fontWeightActive}
              font_weight_inactive = ${toString hypr.group.groupbar.fontWeightInactive}
              gradients = ${boolToString hypr.group.groupbar.gradients}
              height = ${toString hypr.group.groupbar.height}
              indicator_gap = ${toString hypr.group.groupbar.indicatorGap}
              indicator_height = ${toString hypr.group.groupbar.indicatorHeight}
              stacked = ${boolToString hypr.group.groupbar.stacked}
              priority = ${toString hypr.group.groupbar.priority}
              render_titles = ${boolToString hypr.group.groupbar.renderTitles}
              text_offset = ${toString hypr.group.groupbar.textOffset}
              scrolling = ${boolToString hypr.group.groupbar.scrolling}
              rounding = ${toString hypr.group.groupbar.rounding}
              gradient_rounding = ${toString hypr.group.groupbar.gradientRounding}
              round_only_edges = ${boolToString hypr.group.groupbar.roundOnlyEdges}
              gradient_round_only_edges = ${boolToString hypr.group.groupbar.gradientRoundOnlyEdges}
              text_color = ${toString hypr.group.groupbar.textColor}
              col.active = ${toString hypr.group.groupbar.col.active}
              col.inactive = ${toString hypr.group.groupbar.col.inactive}
              col.locked_active = ${toString hypr.group.groupbar.col.lockedActive}
              col.locked_inactive = ${toString hypr.group.groupbar.col.lockedInactive}
              gaps_in = ${toString hypr.group.groupbar.gapsIn}
              gaps_out = ${toString hypr.group.groupbar.gapsOut}
              keep_upper_gap = ${boolToString hypr.group.groupbar.keepUpperGap}
          }
      }

      misc {
          disable_hyprland_logo = ${boolToString hypr.misc.disableHyprlandLogo}
          disable_splash_rendering = ${boolToString hypr.misc.disableSplashRendering}
          col.splash = ${toString hypr.misc.col.splash}
          font_family = ${toString hypr.misc.fontFamily}
          splash_font_family = ${toString hypr.misc.splashFontFamily}
          force_default_wallpaper = ${toString hypr.misc.forceDefaultWallpaper}
          vfr = ${toString hypr.misc.vfr}
          vrr = ${toString hypr.misc.vrr}
          mouse_move_enables_dpms = ${boolToString hypr.misc.mouseMoveEnablesDPMS}
          key_press_enables_dpms = ${boolToString hypr.misc.keyPressEnablesDPMS}
          always_follow_on_dnd = ${boolToString hypr.misc.alwaysFollowOnDnd}
          layers_hog_keyboard_focus = ${boolToString hypr.misc.layersHogKeyboardFocus}
          animate_manual_resizes = ${boolToString hypr.misc.animateManualResizes}
          animate_mouse_windowdragging = ${boolToString hypr.misc.animateMouseWindowdragging}
          disable_autoreload = ${boolToString hypr.misc.disableAutoreload}
          enable_swallow = ${boolToString hypr.misc.enableSwallow}
          swallow_regex = ${toString hypr.misc.swallowRegex}
          swallow_exception_regex = ${toString hypr.misc.swallowExceptionRegex}
          focus_on_activate = ${boolToString hypr.misc.focusOnActivate}
          mouse_move_focuses_monitor = ${boolToString hypr.misc.mouseMoveFocusesMonitor}
          allow_session_lock_restore = ${boolToString hypr.misc.allowSessionLockRestore}
          background_color = ${toString hypr.misc.backgroundColor}
          close_special_on_empty = ${boolToString hypr.misc.closeSpecialOnEmpty}
          new_window_takes_over_fullscreen = ${toString hypr.misc.newWindowTakesOverFullscreen}
          exit_window_retains_fullscreen = ${boolToString hypr.misc.exitWindowRetainsFullscreen}
          initial_workspace_tracking = ${toString hypr.misc.initialWorkspaceTracking}
          middle_click_paste = ${boolToString hypr.misc.middleClickPaste}
          render_unfocused_fps = ${toString hypr.misc.renderUnfocusedFps}
          disable_xdg_env_checks = ${boolToString hypr.misc.disableXdgEnvChecks}
          disable_hyprland_guiutils_check = ${boolToString hypr.misc.disableHyprlandGuiUtilsCheck}
          lockdead_screen_delay = ${toString hypr.misc.lockdeadScreenDelay}
          enable_anr_dialog = ${boolToString hypr.misc.enableAnrDialog}
          anr_missed_pings = ${toString hypr.misc.anrMissedPings}
      }

      binds {
          pass_mouse_when_bound = ${boolToString hypr.binds.passMouseWhenBound}
          scroll_event_delay = ${toString hypr.binds.scrollEventDelay}
          workspace_back_and_forth = ${boolToString hypr.binds.workspaceBackAndForth}
          hide_special_on_workspace_change = ${boolToString hypr.binds.hideSpecialOnWorkspaceChange}
          allow_workspace_cycles = ${boolToString hypr.binds.allowWorkspaceCycles}
          workspace_center_on = ${toString hypr.binds.workspaceCenterOn}
          focus_preferred_method = ${toString hypr.binds.focusPreferredMethod}
          ignore_group_lock = ${boolToString hypr.binds.ignoreGroupLock}
          movefocus_cycles_fullscreen = ${boolToString hypr.binds.movefocusCyclesFullscreen}
          movefocus_cycles_groupfirst = ${boolToString hypr.binds.movefocusCyclesGroupfirst}
          disable_keybind_grabbing = ${boolToString hypr.binds.disableKeybindGrabbing}
          window_direction_monitor_fallback = ${boolToString hypr.binds.windowDirectionMonitorFallback}
          allow_pin_fullscreen = ${boolToString hypr.binds.allowPinFullscreen}
          drag_threshold = ${toString hypr.binds.dragThreshold}
      }

      xwayland {
          enabled = ${boolToString hypr.xwayland.enabled}
          use_nearest_neighbor = ${boolToString hypr.xwayland.useNearestNeighbor}
          force_zero_scaling = ${boolToString hypr.xwayland.forceZeroScaling}
          create_abstract_socket = ${boolToString hypr.xwayland.createAbstractSocket}
      }

      opengl {
          nvidia_anti_flicker = ${boolToString hypr.opengl.nvidiaAntiFlicker}
      }

      render {
          direct_scanout = ${toString hypr.render.directScanout}
          expand_undersized_textures = ${boolToString hypr.render.expandUndersizedTextures}
          xp_mode = ${boolToString hypr.render.xpMode}
          ctm_animation = ${toString hypr.render.ctmAnimation}
          cm_fs_passthrough = ${toString hypr.render.cmFsPassthrough}
          cm_enabled = ${boolToString hypr.render.cmEnabled}
          send_content_type = ${boolToString hypr.render.sendContentType}
      }

      cursor {
          sync_gsettings_theme = ${boolToString hypr.cursor.syncGsettingsTheme}
          no_hardware_cursors = ${toString hypr.cursor.noHardwareCursors}
          no_break_fs_vrr = ${toString hypr.cursor.noBreakFsVrr}
          min_refresh_rate = ${toString hypr.cursor.minRefreshRate}
          hotspot_padding = ${toString hypr.cursor.hotspotPadding}
          inactive_timeout = ${toString hypr.cursor.inactiveTimeout}
          no_warps = ${boolToString hypr.cursor.noWarps}
          persistent_warps = ${boolToString hypr.cursor.persistentWarps}
          warp_on_change_workspace = ${toString hypr.cursor.warpOnChangeWorkspace}
          warp_on_toggle_special = ${toString hypr.cursor.warpOnToggleSpecial}
          default_monitor = ${toString hypr.cursor.defaultMonitor}
          zoom_factor = ${toString hypr.cursor.zoomFactor}
          zoom_rigid = ${boolToString hypr.cursor.zoomRigid}
          enable_hyprcursor = ${boolToString hypr.cursor.enableHyprcursor}
          hide_on_key_press = ${boolToString hypr.cursor.hideOnKeyPress}
          hide_on_touch = ${boolToString hypr.cursor.hideOnTouch}
          use_cpu_buffer = ${toString hypr.cursor.useCpuBuffer}
          warp_back_after_non_mouse_input = ${boolToString hypr.cursor.warpBackAfterNonMouseInput}
      }

      ecosystem {
          no_update_news = ${boolToString hypr.ecosystem.noUpdateNews}
          no_donation_nag = ${boolToString hypr.ecosystem.noDonationNag}
          enforce_permissions = ${boolToString hypr.ecosystem.enforcePermissions}
      }

      dwindle {
          pseudotile = ${boolToString hypr.dwindle.pseudotile}
          preserve_split = ${boolToString hypr.dwindle.preserveSplit}
      }

      master {
          new_status = ${toString hypr.master.newStatus}
      }

      ${concatStringsSep "\n" hypr.monitors.displays}

      ${
        if hypr.monitors.addDefault
        then "monitor = ,preferred, auto, auto"
        else ""
      }

      ${concatStringsSep "\n" (map (wr: "windowrule = " + wr) hypr.windowrules)}

      ${concatStringsSep "\n" (map (ws: "workspace = " + ws) hypr.workspaces)}

      ${
        concatStringsSep "\n" (
          if hypr.monitors.bindWorkspaces == "interlaced"
          then (map (x: "workspace = ${toString (x + 1)}, persistent:true, monitor:${(elemAt hypr.monitors.displays (x - ((length hypr.monitors.displays) * (x / (length hypr.monitors.displays))))).output}") (genList (x: x) 10))
          else []
        )
      }
    '';
  };
}
