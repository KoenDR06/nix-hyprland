{lib, ...}: let
  inherit (lib) mkOption types;

  # v0.52.1
  vec2 = types.submodule {
    options = {
      x = mkOption {type = types.int;};
      y = mkOption {type = types.int;};
    };
  };
  fontWeight = types.enum ["thin" "ultralight" "light" "semilight" "book" "normal" "medium" "semibold" "bold" "ultrabold" "heavy" "ultraheavy"];
in {
  options.nix-hyprland = {
    general = {
      borderSize = mkOption {
        description = "size of the border around windows";
        type = types.int;
        default = 1;
      };
      gapsIn = mkOption {
        description = "gaps between windows, also supports css style gaps (top, right, bottom, left -> 5,10,15,20)";
        type = types.int;
        default = 5;
      };
      gapsOut = mkOption {
        description = "gaps between windows and monitor edges, also supports css style gaps (top, right, bottom, left -> 5,10,15,20)";
        type = types.int;
        default = 20;
      };
      floatGaps = mkOption {
        description = "gaps between windows and monitor edges for floating windows, also supports css style gaps (top, right, bottom, left -> 5 10 15 20). -1 means default";
        type = types.int;
        default = 0;
      };
      gapsWorkspaces = mkOption {
        description = "gaps between workspaces. Stacks with gapsOut.";
        type = types.int;
        default = 0;
      };
      col.inactiveBorder = mkOption {
        description = "border color for inactive windows";
        type = types.str;
        default = "0xff444444";
      };
      col.activeBorder = mkOption {
        description = "border color for the active window";
        type = types.str;
        default = "0xffffffff";
      };
      col.nogroupBorder = mkOption {
        description = "inactive border color for window that cannot be added to a group (see `denywindowfromgroup` dispatcher)";
        type = types.str;
        default = "0xffffaaff";
      };
      col.nogroupBorderActive = mkOption {
        description = "active border color for window that cannot be added to a group";
        type = types.str;
        default = "0xffff00ff";
      };
      layout = mkOption {
        description = "which layout to use.";
        type = types.enum ["dwindle" "master"];
        default = "dwindle";
      };
      noFocusFallback = mkOption {
        description = "if true, will not fall back to the next available window when moving focus in a direction where no window was found";
        type = types.bool;
        default = false;
      };
      resizeOnBorder = mkOption {
        description = "enables resizing windows by clicking and dragging on borders and gaps";
        type = types.bool;
        default = false;
      };
      extendBorderGrabArea = mkOption {
        description = "extends the area around the border where you can click and drag on, only used when `general:resizeOnBorder` is on.";
        type = types.int;
        default = 15;
      };
      hoverIconOnBorder = mkOption {
        description = "show a cursor icon when hovering over borders, only used when `general:resizeOnBorder` is on.";
        type = types.bool;
        default = true;
      };
      allowTearing = mkOption {
        description = "master switch for allowing tearing to occur. See [the Tearing page](../Tearing).";
        type = types.bool;
        default = false;
      };
      resizeCorner = mkOption {
        description = "force floating windows to use a specific corner when being resized (1-4 going clockwise from top left, 0 to disable)";
        type = types.int;
        default = 0;
      };
      modalParentBlocking = mkOption {
        description = "whether parent windows of modals will be interactive";
        type = types.bool;
        default = true;
      };
      locale = mkOption {
        description = "overrides the system locale (e.g. enuS, es)";
        type = types.str;
        default = "";
      };
    };

    general.snap = {
      enabled = mkOption {
        description = "enable snapping for floating windows";
        type = types.bool;
        default = false;
      };
      windowGap = mkOption {
        description = "minimum gap in pixels between windows before snapping";
        type = types.int;
        default = 10;
      };
      monitorGap = mkOption {
        description = "minimum gap in pixels between window and monitor edges before snapping";
        type = types.int;
        default = 10;
      };
      borderOverlap = mkOption {
        description = "if true, windows snap such that only one border's worth of space is between them";
        type = types.bool;
        default = false;
      };
      respectGaps = mkOption {
        description = "if true, snapping will respect gaps between windows(set in general:gapsIn)";
        type = types.bool;
        default = false;
      };
    };

    decoration = {
      rounding = mkOption {
        description = "rounded corners' radius (in layout px)";
        type = types.int;
        default = 0;
      };
      roundingPower = mkOption {
        description = "adjusts the curve used for rounding corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner.";
        type = types.numbers.between 1.0 10.0;
        default = 2.0;
      };
      activeOpacity = mkOption {
        description = "opacity of active windows.";
        type = types.numbers.between 0.0 1.0;
        default = 1.0;
      };
      inactiveOpacity = mkOption {
        description = "opacity of inactive windows.";
        type = types.numbers.between 0.0 1.0;
        default = 1.0;
      };
      fullscreenOpacity = mkOption {
        description = "opacity of fullscreen windows.";
        type = types.numbers.between 0.0 1.0;
        default = 1.0;
      };
      dimModal = mkOption {
        description = "enables dimming of parents of modal windows";
        type = types.bool;
        default = true;
      };
      dimInactive = mkOption {
        description = "enables dimming of inactive windows";
        type = types.bool;
        default = false;
      };
      dimStrength = mkOption {
        description = "how much inactive windows should be dimmed";
        type = types.numbers.between 0.0 1.0;
        default = 0.5;
      };
      dimSpecial = mkOption {
        description = "how much to dim the rest of the screen by when a special workspace is open.";
        type = types.numbers.between 0.0 1.0;
        default = 0.2;
      };
      dimAround = mkOption {
        description = "how much the `dimAround` window rule should dim by.";
        type = types.numbers.between 0.0 1.0;
        default = 0.4;
      };
      screenShader = mkOption {
        description = "a path to a custom shader to be applied at the end of rendering. See `examples/screenShader.frag` for an example.";
        type = types.str;
        default = "";
      };
      borderPartOfWindow = mkOption {
        description = "whether the window border should be a part of the window";
        type = types.bool;
        default = true;
      };
    };

    decoration.blur = {
      enabled = mkOption {
        description = "enable kawase window background blur";
        type = types.bool;
        default = true;
      };
      size = mkOption {
        description = "blur size (distance)";
        type = types.int;
        default = 8;
      };
      passes = mkOption {
        description = "the amount of passes to perform";
        type = types.int;
        default = 1;
      };
      ignoreOpacity = mkOption {
        description = "make the blur layer ignore the opacity of the window";
        type = types.bool;
        default = true;
      };
      newOptimizations = mkOption {
        description = "whether to enable further optimizations to the blur. Recommended to leave on, as it will massively improve performance.";
        type = types.bool;
        default = true;
      };
      xray = mkOption {
        description = "if enabled, floating windows will ignore tiled windows in their blur. Only available if newOptimizations is true. Will reduce overhead on floating blur significantly.";
        type = types.bool;
        default = false;
      };
      noise = mkOption {
        description = "how much noise to apply.";
        type = types.numbers.between 0.0 1.0;
        default = 0.0117;
      };
      contrast = mkOption {
        description = "contrast modulation for blur.";
        type = types.numbers.between 0.0 2.0;
        default = 0.8916;
      };
      brightness = mkOption {
        description = "brightness modulation for blur.";
        type = types.numbers.between 0.0 2.0;
        default = 0.8172;
      };
      vibrancy = mkOption {
        description = "Increase saturation of blurred colors.";
        type = types.numbers.between 0.0 1.0;
        default = 0.1696;
      };
      vibrancyDarkness = mkOption {
        description = "How strong the effect of `vibrancy` is on dark areas.";
        type = types.numbers.between 0.0 1.0;
        default = 0.0;
      };
      special = mkOption {
        description = "whether to blur behind the special workspace (note: expensive)";
        type = types.bool;
        default = false;
      };
      popups = mkOption {
        description = "whether to blur popups (e.g. right-click menus)";
        type = types.bool;
        default = false;
      };
      popupsIgnorealpha = mkOption {
        description = "works like ignoreAlpha in layer rules. If pixel opacity is below set value, will not blur.";
        type = types.numbers.between 0.0 1.0;
        default = 0.2;
      };
      inputMethods = mkOption {
        description = "whether to blur input methods (e.g. fcitx5)";
        type = types.bool;
        default = false;
      };
      inputMethodsIgnorealpha = mkOption {
        description = "works like ignoreAlpha in layer rules. If pixel opacity is below set value, will not blur.";
        type = types.numbers.between 0.0 1.0;
        default = 0.2;
      };
    };

    decoration.shadow = {
      enabled = mkOption {
        description = "enable drop shadows on windows";
        type = types.bool;
        default = true;
      };
      range = mkOption {
        description = "Shadow range ('size') in layout px";
        type = types.int;
        default = 4;
      };
      renderPower = mkOption {
        description = "in what power to render the falloff (more power, the faster the falloff)";
        type = types.ints.between 1 4;
        default = 3;
      };
      sharp = mkOption {
        description = "if enabled, will make the shadows sharp, akin to an infinite render power";
        type = types.bool;
        default = false;
      };
      ignoreWindow = mkOption {
        description = "if true, the shadow will not be rendered behind the window itself, only around it.";
        type = types.bool;
        default = true;
      };
      color = mkOption {
        description = "shadow's color. Alpha dictates shadow's opacity.";
        type = types.str;
        default = "0xee1a1a1a";
      };
      colorInactive = mkOption {
        description = "inactive shadow color. (if not set, will fall back to color)";
        type = types.str;
        default = "0xee1a1a1a";
      };
      offset = mkOption {
        description = "shadow's rendering offset.";
        type = vec2;
        default = {
          x = 0;
          y = 0;
        };
      };
      scale = mkOption {
        description = "shadow's scale.";
        type = types.numbers.between 0.0 1.0;
        default = 1.0;
      };
    };

    animations = {
      enabled = mkOption {
        description = "enable animations";
        type = types.bool;
        default = true;
      };
      workspaceWraparound = mkOption {
        description = "enable workspace wraparound, causing directional workspace animations to animate as if the first and last workspaces were adjacent";
        type = types.bool;
        default = false;
      };
    };

    input = {
      kbModel = mkOption {
        description = "Appropriate XKB keymap parameter. See the note below.";
        type = types.str;
        default = "";
      };
      kbLayout = mkOption {
        description = "Appropriate XKB keymap parameter";
        type = types.str;
        default = "us";
      };
      kbVariant = mkOption {
        description = "Appropriate XKB keymap parameter";
        type = types.str;
        default = "";
      };
      kbOptions = mkOption {
        description = "Appropriate XKB keymap parameter";
        type = types.str;
        default = "";
      };
      kbRules = mkOption {
        description = "Appropriate XKB keymap parameter";
        type = types.str;
        default = "";
      };
      kbFile = mkOption {
        description = "If you prefer, you can use a path to your custom .xkb file.";
        type = types.str;
        default = "";
      };
      numlockByDefault = mkOption {
        description = "Engage numlock by default.";
        type = types.bool;
        default = false;
      };
      resolveBindsBySym = mkOption {
        description = "Determines how keybinds act when multiple layouts are used. If false, keybinds will always act as if the first specified layout is active. If true, keybinds specified by symbols are activated when you type the respective symbol with the current layout.";
        type = types.bool;
        default = false;
      };
      repeatRate = mkOption {
        description = "The repeat rate for held-down keys, in repeats per second.";
        type = types.int;
        default = 25;
      };
      repeatDelay = mkOption {
        description = "Delay before a held-down key is repeated, in milliseconds.";
        type = types.int;
        default = 600;
      };
      sensitivity = mkOption {
        description = "Sets the mouse input sensitivity.";
        type = types.numbers.between (-1.0) 1.0;
        default = 0.0;
      };
      accelProfile = mkOption {
        description = "Sets the cursor acceleration profile.";
        type = types.enum ["" "adaptive" "flat"];
        default = "";
      };
      forceNoAccel = mkOption {
        description = "Force no cursor acceleration. This bypasses most of your pointer settings to get as raw of a signal as possible. **Enabling this is not recommended due to potential cursor desynchronization.**";
        type = types.bool;
        default = false;
      };
      rotation = mkOption {
        description = "Sets the rotation of a device in degrees clockwise off the logical neutral position. Value is clamped to the range 0 to 359.";
        type = types.int;
        default = 0;
      };
      leftHanded = mkOption {
        description = "Switches RMB and LMB";
        type = types.bool;
        default = false;
      };
      scrollPoints = mkOption {
        description = "Sets the scroll acceleration profile, when `accelProfile` is set to `custom`. Has to be in the form `<step> <points>`. Leave empty to have a flat scroll curve.";
        type = types.str;
        default = "";
      };
      scrollMethod = mkOption {
        description = "Sets the scroll method. Can be one of `2fg` (2 fingers), `edge`, `onButtonDown`, `noScroll`. [libinput#scrolling](https://wayland.freedesktop.org/libinput/doc/latest/scrolling.html) [2fg/edge/onButtonDown/noScroll]";
        type = types.enum ["" "2fg" "edge" "onButtonDown" "noScroll"];
        default = "";
      };
      scrollButton = mkOption {
        description = "Sets the scroll button. Has to be an int, cannot be a string. Check `wev` if you have any doubts regarding the ID. 0 means default.";
        type = types.int;
        default = 0;
      };
      scrollButtonLock = mkOption {
        description = "If the scroll button lock is enabled, the button does not need to be held down. Pressing and releasing the button toggles the button lock, which logically holds the button down or releases it. While the button is logically held down, motion events are converted to scroll events.";
        type = types.bool;
        default = false;
      };
      scrollFactor = mkOption {
        description = "Multiplier added to scroll movement for external mice. Note that there is a separate setting for [touchpad scrollFactor](#touchpad). ";
        type = types.float;
        default = 1.0;
      };
      naturalScroll = mkOption {
        description = "Inverts scrolling direction. When enabled, scrolling moves content directly, rather than manipulating a scrollbar.";
        type = types.bool;
        default = false;
      };
      followMouse = mkOption {
        description = "Specify if and how cursor movement should affect window focus. See the note below.";
        type = types.ints.between 0 3;
        default = 1;
      };
      followMouseThreshold = mkOption {
        description = "The smallest distance in logical pixels the mouse needs to travel for the window under it to get focused. Works only with followMouse = 1.";
        type = types.float;
        default = 0.0;
      };
      focusOnClose = mkOption {
        description = "Controls the window focus behavior when a window is closed. When set to 0, focus will shift to the next window candidate. When set to 1, focus will shift to the window under the cursor.";
        type = types.ints.between 0 1;
        default = 0;
      };
      mouseRefocus = mkOption {
        description = "If disabled, mouse focus won't switch to the hovered window unless the mouse crosses a window boundary when `followMouse=1`.";
        type = types.bool;
        default = true;
      };
      floatSwitchOverrideFocus = mkOption {
        description = "If enabled (1 or 2), focus will change to the window under the cursor when changing from tiled-to-floating and vice versa. If 2, focus will also follow mouse on float-to-float switches.";
        type = types.int;
        default = 1;
      };
      specialFallthrough = mkOption {
        description = "if enabled, having only floating windows in the special workspace will not block focusing windows in the regular workspace.";
        type = types.bool;
        default = false;
      };
      offWindowAxisEvents = mkOption {
        description = "Handles axis events around (gaps/border for tiled, dragarea/border for floated) a focused window. `0` ignores axis events `1` sends out-of-bound coordinates `2` fakes pointer coordinates to the closest point inside the window `3` warps the cursor to the closest point inside the window";
        type = types.ints.between 0 3;
        default = 1;
      };
      emulateDiscreteScroll = mkOption {
        description = "Emulates discrete scrolling from high resolution scrolling events. `0` disables it, `1` enables handling of non-standard events only, and `2` force enables all scroll wheel events to be handled";
        type = types.ints.between 0 2;
        default = 1;
      };
    };

    input.touchpad = {
      disableWhileTyping = mkOption {
        description = "Disable the touchpad while typing.";
        type = types.bool;
        default = true;
      };
      naturalScroll = mkOption {
        description = "Inverts scrolling direction. When enabled, scrolling moves content directly, rather than manipulating a scrollbar.";
        type = types.bool;
        default = false;
      };
      scrollFactor = mkOption {
        description = "Multiplier applied to the amount of scroll movement.";
        type = types.float;
        default = 1.0;
      };
      middleButtonEmulation = mkOption {
        description = "Sending LMB and RMB simultaneously will be interpreted as a middle click. This disables any touchpad area that would normally send a middle click based on location.";
        type = types.bool;
        default = false;
      };
      tapButtonMap = mkOption {
        description = "Sets the tap button mapping for touchpad button emulation.";
        type = types.enum ["lrm" "lmr"];
        default = "lrm";
      };
      clickfingerBehavior = mkOption {
        description = "Button presses with 1, 2, or 3 fingers will be mapped to LMB, RMB, and MMB respectively. This disables interpretation of clicks based on location on the touchpad.";
        type = types.bool;
        default = false;
      };
      tapToClick = mkOption {
        description = "Tapping on the touchpad with 1, 2, or 3 fingers will send LMB, RMB, and MMB respectively.";
        type = types.bool;
        default = true;
      };
      dragLock = mkOption {
        description = "When enabled, lifting the finger off while dragging will not drop the dragged item.";
        type = types.ints.between 0 2;
        default = 0;
      };
      tapAndDrag = mkOption {
        description = "Sets the tap and drag mode for the touchpad";
        type = types.bool;
        default = true;
      };
      flipX = mkOption {
        description = "inverts the horizontal movement of the touchpad";
        type = types.bool;
        default = false;
      };
      flipY = mkOption {
        description = "inverts the vertical movement of the touchpad";
        type = types.bool;
        default = false;
      };
      drag3fg = mkOption {
        description = "enables three finger drag, 0 -> disabled, 1 -> 3 fingers, 2 -> 4 fingers";
        type = types.ints.between 0 2;
        default = 0;
      };
    };

    input.touchdevice = {
      transform = mkOption {
        description = "Transform the input from touchdevices. The possible transformations are the same as [those of the monitors](../Monitors/#rotating). `-1` means it's unset.";
        type = types.ints.between (-1) 7;
        default = -1;
      };
      output = mkOption {
        description = "The monitor to bind touch devices. The default is auto-detection. To stop auto-detection, use an empty string or the '[[Empty]]' value.";
        type = types.str;
        default = "[[Auto]]";
      };
      enabled = mkOption {
        description = "Whether input is enabled for touch devices.";
        type = types.bool;
        default = true;
      };
    };

    input.virtualkeyboard = {
      shareStates = mkOption {
        description = "Unify key down states and modifier states with other keyboards. 0 -> no, 1 -> yes, 2 -> yes unless IME client";
        type = types.ints.between 0 2;
        default = 2;
      };
      releasePressedOnClose = mkOption {
        description = "Release all pressed keys by virtual keyboard on close.";
        type = types.bool;
        default = false;
      };
    };

    input.tablet = {
      transform = mkOption {
        description = "transform the input from tablets. The possible transformations are the same as [those of the monitors](../Monitors/#rotating). `-1` means it's unset.";
        type = types.ints.between (-1) 7;
        default = -1;
      };
      output = mkOption {
        description = "the monitor to bind tablets. Can be `current` or a monitor name. Leave empty to map across all monitors.";
        type = types.str;
        default = "";
      };
      regionPosition = mkOption {
        description = "position of the mapped region in monitor layout relative to the top left corner of the bound monitor or all monitors.";
        type = vec2;
        default = {
          x = 0;
          y = 0;
        };
      };
      absoluteRegionPosition = mkOption {
        description = "whether to treat the `regionPosition` as an absolute position in monitor layout. Only applies when `output` is empty.";
        type = types.bool;
        default = false;
      };
      regionSize = mkOption {
        description = "size of the mapped region. When this variable is set, tablet input will be mapped to the region. [0, 0] or invalid size means unset.";
        type = vec2;
        default = {
          x = 0;
          y = 0;
        };
      };
      relativeInput = mkOption {
        description = "whether the input should be relative";
        type = types.bool;
        default = false;
      };
      leftHanded = mkOption {
        description = "if enabled, the tablet will be rotated 180 degrees";
        type = types.bool;
        default = false;
      };
      activeAreaSize = mkOption {
        description = "size of tablet's active area in mm";
        type = vec2;
        default = {
          x = 0;
          y = 0;
        };
      };
      activeAreaPosition = mkOption {
        description = "position of the active area in mm";
        type = vec2;
        default = {
          x = 0;
          y = 0;
        };
      };
    };

    gestures = {
      workspaceSwipeDistance = mkOption {
        description = "in px, the distance of the touchpad gesture";
        type = types.int;
        default = 300;
      };
      workspaceSwipeTouch = mkOption {
        description = "enable workspace swiping from the edge of a touchscreen";
        type = types.bool;
        default = false;
      };
      workspaceSwipeInvert = mkOption {
        description = "invert the direction (touchpad only)";
        type = types.bool;
        default = true;
      };
      workspaceSwipeTouchInvert = mkOption {
        description = "invert the direction (touchscreen only)";
        type = types.bool;
        default = false;
      };
      workspaceSwipeMinSpeedToForce = mkOption {
        description = "minimum speed in px per timepoint to force the change ignoring `cancelRatio`. Setting to `0` will disable this mechanic.";
        type = types.int;
        default = 30;
      };
      workspaceSwipeCancelRatio = mkOption {
        description = "how much the swipe has to proceed in order to commence it. (0.7 -> if > 0.7 * distance, switch, if less, revert)";
        type = types.numbers.between 0.0 1.0;
        default = 0.5;
      };
      workspaceSwipeCreateNew = mkOption {
        description = "whether a swipe right on the last workspace should create a new one.";
        type = types.bool;
        default = true;
      };
      workspaceSwipeDirectionLock = mkOption {
        description = "if enabled, switching direction will be locked when you swipe past the `directionLockThreshold` (touchpad only).";
        type = types.bool;
        default = true;
      };
      workspaceSwipeDirectionLockThreshold = mkOption {
        description = "in px, the distance to swipe before direction lock activates (touchpad only).";
        type = types.int;
        default = 10;
      };
      workspaceSwipeForever = mkOption {
        description = "if enabled, swiping will not clamp at the neighboring workspaces but continue to the further ones.";
        type = types.bool;
        default = false;
      };
      workspaceSwipeUseR = mkOption {
        description = "if enabled, swiping will use the `r` prefix instead of the `m` prefix for finding workspaces.";
        type = types.bool;
        default = false;
      };
      closeMaxTimeout = mkOption {
        description = "the timeout for a window to close when using a 1:1 gesture, in ms";
        type = types.int;
        default = 1000;
      };
    };

    group = {
      autoGroup = mkOption {
        description = "whether new windows will be automatically grouped into the focused unlocked group. Note: if you want to disable autoGroup only for specific windows, use the 'group-barred' instead.";
        type = types.bool;
        default = true;
      };
      insertAfterCurrent = mkOption {
        description = "whether new windows in a group spawn after current or at group tail";
        type = types.bool;
        default = true;
      };
      focusRemovedWindow = mkOption {
        description = "whether Hyprland should focus on the window that has just been moved out of the group";
        type = types.bool;
        default = true;
      };
      dragIntoGroup = mkOption {
        description = "whether dragging a window into a unlocked group will merge them. Options: 0 (disabled), 1 (enabled), 2 (only when dragging into the groupbar)";
        type = types.ints.between 0 2;
        default = 1;
      };
      mergeGroupsOnDrag = mkOption {
        description = "whether window groups can be dragged into other groups";
        type = types.bool;
        default = true;
      };
      mergeGroupsOnGroupbar = mkOption {
        description = "whether one group will be merged with another when dragged into its groupbar";
        type = types.bool;
        default = true;
      };
      mergeFloatedIntoTiledOnGroupbar = mkOption {
        description = "whether dragging a floating window into a tiled window groupbar will merge them";
        type = types.bool;
        default = false;
      };
      groupOnMovetoworkspace = mkOption {
        description = "whether using movetoworkspace[silent] will merge the window into the workspace's solitary unlocked group";
        type = types.bool;
        default = false;
      };
      col.borderActive = mkOption {
        description = "active group border color";
        type = types.str;
        default = "0x66ffff00";
      };
      col.borderInactive = mkOption {
        description = "inactive (out of focus) group border color";
        type = types.str;
        default = "0x66777700";
      };
      col.borderLockedActive = mkOption {
        description = "active locked group border color";
        type = types.str;
        default = "0x66ff5500";
      };
      col.borderLockedInactive = mkOption {
        description = "inactive locked group border color";
        type = types.str;
        default = "0x66775500";
      };
    };

    group.groupbar = {
      enabled = mkOption {
        description = "enables groupbars";
        type = types.bool;
        default = true;
      };
      fontFamily = mkOption {
        description = "font used to display groupbar titles, use `misc:fontFamily` if not specified";
        type = types.str;
        default = "";
      };
      fontSize = mkOption {
        description = "font size of groupbar title";
        type = types.int;
        default = 8;
      };
      fontWeightActive = mkOption {
        description = "font weight of active groupbar title";
        type = fontWeight;
        default = "normal";
      };
      fontWeightInactive = mkOption {
        description = "font weight of inactive groupbar title";
        type = fontWeight;
        default = "normal";
      };
      gradients = mkOption {
        description = "enables gradients";
        type = types.bool;
        default = false;
      };
      height = mkOption {
        description = "height of the groupbar";
        type = types.int;
        default = 14;
      };
      indicatorGap = mkOption {
        description = "height of gap between groupbar indicator and title";
        type = types.int;
        default = 0;
      };
      indicatorHeight = mkOption {
        description = "height of the groupbar indicator";
        type = types.int;
        default = 3;
      };
      stacked = mkOption {
        description = "render the groupbar as a vertical stack";
        type = types.bool;
        default = false;
      };
      priority = mkOption {
        description = "sets the decoration priority for groupbars";
        type = types.int;
        default = 3;
      };
      renderTitles = mkOption {
        description = "whether to render titles in the group bar decoration";
        type = types.bool;
        default = true;
      };
      textOffset = mkOption {
        description = "adjust vertical position for titles";
        type = types.int;
        default = 0;
      };
      scrolling = mkOption {
        description = "whether scrolling in the groupbar changes group active window";
        type = types.bool;
        default = true;
      };
      rounding = mkOption {
        description = "how much to round the indicator";
        type = types.int;
        default = 1;
      };
      roundingPower = mkOption {
        description = " adjusts the curve used for rounding broupbar corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner.";
        type = types.numbers.between 0.0 10.0;
        default = 2.0;
      };
      gradientRounding = mkOption {
        description = "how much to round the gradients";
        type = types.int;
        default = 2;
      };
      gradientRoundingPower = mkOption {
        description = "adjusts the curve used for rounding gradient corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner.";
        type = types.numbers.between 0.0 10.0;
        default = 2.0;
      };
      roundOnlyEdges = mkOption {
        description = "round only the indicator edges of the entire groupbar";
        type = types.bool;
        default = true;
      };
      gradientRoundOnlyEdges = mkOption {
        description = "round only the gradient edges of the entire groupbar";
        type = types.bool;
        default = true;
      };
      textColor = mkOption {
        description = "color for window titles in the groupbar";
        type = types.str;
        default = "0xffffffff";
      };
      textColorInactive = mkOption {
        description = "color for inactive windows' titles in the groupbar (if unset, defaults to textColor)";
        type = types.str;
        default = "unset";
      }; # TODO unset?
      textColorLockedActive = mkOption {
        description = "color for the active window's title in a locked group (if unset, defaults to textColor)";
        type = types.str;
        default = "unset";
      }; # TODO unset?
      textColorLockedInactive = mkOption {
        description = "color for inactive windows' titles in locked groups (if unset, defaults to textColorInactive)";
        type = types.str;
        default = "unset";
      }; # TODO unset?
      col.active = mkOption {
        description = "active group bar background color";
        type = types.str;
        default = "0x66ffff00";
      };
      col.inactive = mkOption {
        description = "inactive (out of focus) group bar background color";
        type = types.str;
        default = "0x66777700";
      };
      col.lockedActive = mkOption {
        description = "active locked group bar background color";
        type = types.str;
        default = "0x66ff5500";
      };
      col.lockedInactive = mkOption {
        description = "inactive locked group bar background color";
        type = types.str;
        default = "0x66775500";
      };
      gapsIn = mkOption {
        description = "gap size between gradients";
        type = types.int;
        default = 2;
      };
      gapsOut = mkOption {
        description = "gap size between gradients and window";
        type = types.int;
        default = 2;
      };
      keepUpperGap = mkOption {
        description = "add or remove upper gap";
        type = types.bool;
        default = true;
      };
      blur = mkOption {
        description = "applies blur to the groupbar indicators and gradients";
        type = types.bool;
        default = false;
      };
    };

    misc = {
      disableHyprlandLogo = mkOption {
        description = "disables the random Hyprland logo / anime girl background. :(";
        type = types.bool;
        default = false;
      };
      disableSplashRendering = mkOption {
        description = "disables the Hyprland splash rendering. (requires a monitor reload to take effect)";
        type = types.bool;
        default = false;
      };
      disableScaleNotification = mkOption {
        description = "disables notification popup when a monitor fails to set a suitable scale";
        type = types.bool;
        default = false;
      };
      col.splash = mkOption {
        description = "Changes the color of the splash text (requires a monitor reload to take effect).";
        type = types.str;
        default = "0xffffffff";
      };
      fontFamily = mkOption {
        description = "Set the global default font to render the text including debug fps/notification, config error messages and etc., selected from system fonts.";
        type = types.str;
        default = "Sans";
      };
      splashFontFamily = mkOption {
        description = "Changes the font used to render the splash text, selected from system fonts (requires a monitor reload to take effect).";
        type = types.str;
        default = "";
      };
      forceDefaultWallpaper = mkOption {
        description = "Enforce any of the 3 default wallpapers. Setting this to `0` or `1` disables the anime background. `-1` means 'random'.";
        type = types.ints.between (-1) 2;
        default = -1;
      };
      vfr = mkOption {
        description = "controls the VFR status of Hyprland. Heavily recommended to leave enabled to conserve resources.";
        type = types.bool;
        default = true;
      };
      vrr = mkOption {
        description = "controls the VRR (Adaptive Sync) of your monitors. 0 - off, 1 - on, 2 - fullscreen only, 3 - fullscreen with `video` or `game` content type";
        type = types.ints.between 0 3;
        default = 0;
      };
      mouseMoveEnablesDPMS = mkOption {
        description = "If DPMS is set to off, wake up the monitors if the mouse moves.";
        type = types.bool;
        default = false;
      };
      keyPressEnablesDPMS = mkOption {
        description = "If DPMS is set to off, wake up the monitors if a key is pressed.";
        type = types.bool;
        default = false;
      };
      nameVkAfterProc = mkOption {
        description = "Name virtual keyboards after the processes that create them. E.g. /usr/bin/fcitx5 will have hl-virtual-keyboard-fcitx5.";
        type = types.bool;
        default = true;
      };
      alwaysFollowOnDnd = mkOption {
        description = "Will make mouse focus follow the mouse when drag and dropping. Recommended to leave it enabled, especially for people using focus follows mouse at 0.";
        type = types.bool;
        default = true;
      };
      layersHogKeyboardFocus = mkOption {
        description = "If true, will make keyboard-interactive layers keep their focus on mouse move (e.g. wofi, bemenu)";
        type = types.bool;
        default = true;
      };
      animateManualResizes = mkOption {
        description = "If true, will animate manual window resizes/moves";
        type = types.bool;
        default = false;
      };
      animateMouseWindowdragging = mkOption {
        description = "If true, will animate windows being dragged by mouse, note that this can cause weird behavior on some curves";
        type = types.bool;
        default = false;
      };
      disableAutoreload = mkOption {
        description = "If true, the config will not reload automatically on save, and instead needs to be reloaded with `hyprctl reload`. Might save on battery.";
        type = types.bool;
        default = false;
      };
      enableSwallow = mkOption {
        description = "Enable window swallowing";
        type = types.bool;
        default = false;
      };
      swallowRegex = mkOption {
        description = "The Class regex to be used for windows that should be swallowed (usually, a terminal).";
        type = types.str;
        default = "";
      };
      swallowExceptionRegex = mkOption {
        description = "The Title regex to be used for windows that should Not be swallowed by the windows specified in swallowRegex  (e.g. wev). The regex is matched against the parent (e.g. Kitty) window's title on the assumption that it changes to whatever process it's running.";
        type = types.str;
        default = "";
      };
      focusOnActivate = mkOption {
        description = "Whether Hyprland should focus an app that requests to be focused (an `activate` request)";
        type = types.bool;
        default = false;
      };
      mouseMoveFocusesMonitor = mkOption {
        description = "Whether mouse moving into a different monitor should focus it";
        type = types.bool;
        default = true;
      };
      allowSessionLockRestore = mkOption {
        description = "if true, will allow you to restart a lockscreen app in case it crashes";
        type = types.bool;
        default = false;
      };
      sessionLockXray = mkOption {
        description = "if true, keep rendering workspaces below your lockscreen";
        type = types.bool;
        default = false;
      };
      backgroundColor = mkOption {
        description = "change the background color. (requires enabled `disableHyprlandLogo`)";
        type = types.str;
        default = "0x111111";
      };
      closeSpecialOnEmpty = mkOption {
        description = "close the special workspace if the last window is removed";
        type = types.bool;
        default = true;
      };
      newWindowTakesOverFullscreen = mkOption {
        description = "if there is a fullscreen or maximized window, decide whether a tiled window requested to focus should replace it, stay behind or disable the fullscreen/maximized state. 0 - ignore focus request (keep focus on fullscreen window), 1 - takes over, 2 - unfullscreen/unmaximize [0/1/2]";
        type = types.ints.between 0 2;
        default = 2;
      };
      exitWindowRetainsFullscreen = mkOption {
        description = "if true, closing a fullscreen window makes the next focused window fullscreen";
        type = types.bool;
        default = false;
      };
      initialWorkspaceTracking = mkOption {
        description = "if enabled, windows will open on the workspace they were invoked on. 0 - disabled, 1 - single-shot, 2 - persistent (all children too)";
        type = types.ints.between 0 2;
        default = 1;
      };
      middleClickPaste = mkOption {
        description = "whether to enable middle-click-paste (aka primary selection)";
        type = types.bool;
        default = true;
      };
      renderUnfocusedFps = mkOption {
        description = "the maximum limit for renderUnfocused windows' fps in the background (see also [Window-Rules](../Window-Rules/#dynamic-effects) - `renderUnfocused`)";
        type = types.int;
        default = 15;
      };
      disableXdgEnvChecks = mkOption {
        description = "disable the warning if XDG environment is externally managed";
        type = types.bool;
        default = false;
      };
      disableHyprlandGuiUtilsCheck = mkOption {
        description = "disable the warning if hyprland-qtutils is not installed";
        type = types.bool;
        default = false;
      };
      lockdeadScreenDelay = mkOption {
        description = "delay after which the 'lockdead' screen will appear in case a lockscreen app fails to cover all the outputs (5 seconds max)";
        type = types.int;
        default = 1000;
      };
      enableAnrDialog = mkOption {
        description = "whether to enable the ANR (app not responding) dialog when your apps hang";
        type = types.bool;
        default = true;
      };
      anrMissedPings = mkOption {
        description = "number of missed pings before showing the ANR dialog";
        type = types.int;
        default = 5;
      };
      sizeLimitsTiled = mkOption {
        description = "whether to apply minSize and maxSize rules to tiled windows";
        type = types.bool;
        default = false;
      };
    };

    binds = {
      passMouseWhenBound = mkOption {
        description = "if disabled, will not pass the mouse events to apps / dragging windows around if a keybind has been triggered.";
        type = types.bool;
        default = false;
      };
      scrollEventDelay = mkOption {
        description = "in ms, how many ms to wait after a scroll event to allow passing another one for the binds.";
        type = types.int;
        default = 300;
      };
      workspaceBackAndForth = mkOption {
        description = "If enabled, an attempt to switch to the currently focused workspace will instead switch to the previous workspace. Akin to i3's AutoBackAndForth.";
        type = types.bool;
        default = false;
      };
      hideSpecialOnWorkspaceChange = mkOption {
        description = "If enabled, changing the active workspace (including to itself) will hide the special workspace on the monitor where the newly active workspace resides.";
        type = types.bool;
        default = false;
      };
      allowWorkspaceCycles = mkOption {
        description = "If enabled, workspaces don't forget their previous workspace, so cycles can be created by switching to the first workspace in a sequence, then endlessly going to the previous workspace.";
        type = types.bool;
        default = false;
      };
      workspaceCenterOn = mkOption {
        description = "Whether switching workspaces should center the cursor on the workspace (0) or on the last active window for that workspace (1)";
        type = types.ints.between 0 1;
        default = 0;
      };
      focusPreferredMethod = mkOption {
        description = "sets the preferred focus finding method when using `focuswindow`/`movewindow`/etc with a direction. 0 - history (recent have priority), 1 - length (longer shared edges have priority)";
        type = types.int;
        default = 0;
      };
      ignoreGroupLock = mkOption {
        description = "If enabled, dispatchers like `moveintogroup`, `moveoutofgroup` and `movewindoworgroup` will ignore lock per group.";
        type = types.bool;
        default = false;
      };
      movefocusCyclesFullscreen = mkOption {
        description = "If enabled, when on a fullscreen window, `movefocus` will cycle fullscreen, if not, it will move the focus in a direction.";
        type = types.bool;
        default = false;
      };
      movefocusCyclesGroupfirst = mkOption {
        description = "If enabled, when in a grouped window, movefocus will cycle windows in the groups first, then at each ends of tabs, it'll move on to other windows/groups";
        type = types.bool;
        default = false;
      };
      disableKeybindGrabbing = mkOption {
        description = "If enabled, apps that request keybinds to be disabled (e.g. VMs) will not be able to do so.";
        type = types.bool;
        default = false;
      };
      windowDirectionMonitorFallback = mkOption {
        description = "If enabled, moving a window or focus over the edge of a monitor with a direction will move it to the next monitor in that direction.";
        type = types.bool;
        default = true;
      };
      allowPinFullscreen = mkOption {
        description = "If enabled, Allow fullscreen to pinned windows, and restore their pinned status afterwards";
        type = types.bool;
        default = false;
      };
      dragThreshold = mkOption {
        description = "Movement threshold in pixels for window dragging and c/g bind flags. 0 to disable and grab on mousedown.";
        type = types.int;
        default = 0;
      };
    };

    xwayland = {
      enabled = mkOption {
        description = "allow running applications using X11";
        type = types.bool;
        default = true;
      };
      useNearestNeighbor = mkOption {
        description = "uses the nearest neighbor filtering for xwayland apps, making them pixelated rather than blurry";
        type = types.bool;
        default = true;
      };
      forceZeroScaling = mkOption {
        description = "forces a scale of 1 on xwayland windows on scaled displays.";
        type = types.bool;
        default = false;
      };
      createAbstractSocket = mkOption {
        description = "Create the [abstract Unix domain socket](../XWayland/#abstract-unix-domain-socket) for XWayland connections. (XWayland restart is required for changes to take effect; Linux only)";
        type = types.bool;
        default = false;
      };
    };

    opengl = {
      nvidiaAntiFlicker = mkOption {
        description = "reduces flickering on nvidia at the cost of possible frame drops on lower-end GPUs. On non-nvidia, this is ignored.";
        type = types.bool;
        default = true;
      };
    };

    render = {
      directScanout = mkOption {
        description = "Enables direct scanout. Direct scanout attempts to reduce lag when there is only one fullscreen application on a screen (e.g. game). It is also recommended to set this to false if the fullscreen application shows graphical glitches. 0 - off, 1 - on, 2 - auto (on with content type 'game')";
        type = types.ints.between 0 2;
        default = 0;
      };
      expandUndersizedTextures = mkOption {
        description = "Whether to expand undersized textures along the edge, or rather stretch the entire texture.";
        type = types.bool;
        default = true;
      };
      xpMode = mkOption {
        description = "Disables back buffer and bottom layer rendering.";
        type = types.bool;
        default = false;
      };
      ctmAnimation = mkOption {
        description = "Whether to enable a fade animation for CTM changes (hyprsunset). 2 means 'auto' which disables them on Nvidia.";
        type = types.int;
        default = 2;
      };
      cmFsPassthrough = mkOption {
        description = "Passthrough color settings for fullscreen apps when possible. 0 - off, 1 - always, 2 - hdr only";
        type = types.int;
        default = 2;
      };
      cmEnabled = mkOption {
        description = "Whether the color management pipeline should be enabled or not (requires a restart of Hyprland to fully take effect)";
        type = types.bool;
        default = true;
      };
      sendContentType = mkOption {
        description = "Report content type to allow monitor profile autoswitch (may result in a black screen during the switch)";
        type = types.bool;
        default = true;
      };
      cmAutoHdr = mkOption {
        description = "Auto-switch to HDR in fullscreen when needed. 0 - off, 1 - switch to `cm, hdr`, 2 - switch to `cm, hdredid`";
        type = types.ints.between 0 2;
        default = 1;
      };
      newRenderScheduling = mkOption {
        description = "Automatically uses triple buffering when needed, improves FPS on underpowered devices.";
        type = types.bool;
        default = false;
      };
      nonShaderCm = mkOption {
        description = "Enable CM without shader. 0 - disable, 1 - whenever possible, 2 - DS and passthrough only, 3 - disable and ignore CM issues";
        type = types.ints.between 0 3;
        default = 3;
      };
      cmSdrEotf = mkOption {
        description = "Default transfer function for displaying SDR apps. 0 - Treat unspecified as sRGB, 1 - Treat unspecified as Gamma 2.2, 2 - Treat unspecified and sRGB as Gamma 2.2";
        type = types.ints.between 0 2;
        default = 0;
      };
    };

    cursor = {
      invisible = mkOption {
        description = "don't render cursors";
        type = types.bool;
        default = false;
      };
      syncGsettingsTheme = mkOption {
        description = "sync xcursor theme with gsettings, it applies cursor-theme and cursor-size on theme load to gsettings making most CSD gtk based clients use same xcursor theme and size.";
        type = types.bool;
        default = true;
      };
      noHardwareCursors = mkOption {
        description = "disables hardware cursors. 0 - use hw cursors if possible, 1 - don't use hw cursors, 2 - auto (disable when tearing)";
        type = types.ints.between 0 2;
        default = 2;
      };
      noBreakFsVrr = mkOption {
        description = "disables scheduling new frames on cursor movement for fullscreen apps with VRR enabled to avoid framerate spikes (may require noHardwareCursors = true) 0 - off, 1 - on, 2 - auto (on with content type 'game')";
        type = types.ints.between 0 2;
        default = 2;
      };
      minRefreshRate = mkOption {
        description = "minimum refresh rate for cursor movement when `noBreakFsVrr` is active. Set to minimum supported refresh rate or higher";
        type = types.int;
        default = 24;
      };
      hotspotPadding = mkOption {
        description = "the padding, in logical px, between screen edges and the cursor";
        type = types.int;
        default = 1;
      };
      inactiveTimeout = mkOption {
        description = "in seconds, after how many seconds of cursor's inactivity to hide it. Set to `0` for never.";
        type = types.number;
        default = 0;
      };
      noWarps = mkOption {
        description = "if true, will not warp the cursor in many cases (focusing, keybinds, etc)";
        type = types.bool;
        default = false;
      };
      persistentWarps = mkOption {
        description = "When a window is refocused, the cursor returns to its last position relative to that window, rather than to the centre.";
        type = types.bool;
        default = false;
      };
      warpOnChangeWorkspace = mkOption {
        description = "Move the cursor to the last focused window after changing the workspace. Options: 0 (Disabled), 1 (Enabled), 2 (Force - ignores cursor:noWarps option)";
        type = types.ints.between 0 2;
        default = 0;
      };
      warpOnToggleSpecial = mkOption {
        description = "Move the cursor to the last focused window when toggling a special workspace. Options: 0 (Disabled), 1 (Enabled), 2 (Force - ignores cursor:noWarps option)";
        type = types.ints.between 0 2;
        default = 0;
      };
      defaultMonitor = mkOption {
        description = "the name of a default monitor for the cursor to be set to on startup (see `hyprctl monitors` for names)";
        type = types.str;
        default = "";
      };
      zoomFactor = mkOption {
        description = "the factor to zoom by around the cursor. Like a magnifying glass. Minimum 1.0 (meaning no zoom)";
        type = types.addCheck types.number (x: x >= 1);
        default = 1.0;
      };
      zoomRigid = mkOption {
        description = "whether the zoom should follow the cursor rigidly (cursor is always centered if it can be) or loosely";
        type = types.bool;
        default = false;
      };
      enableHyprcursor = mkOption {
        description = "whether to enable hyprcursor support";
        type = types.bool;
        default = true;
      };
      hideOnKeyPress = mkOption {
        description = "Hides the cursor when you press any key until the mouse is moved.";
        type = types.bool;
        default = false;
      };
      hideOnTouch = mkOption {
        description = "Hides the cursor when the last input was a touch input until a mouse input is done.";
        type = types.bool;
        default = true;
      };
      useCpuBuffer = mkOption {
        description = "Makes HW cursors use a CPU buffer. Required on Nvidia to have HW cursors. 0 - off, 1 - on, 2 - auto (nvidia only)";
        type = types.ints.between 0 2;
        default = 2;
      };
      warpBackAfterNonMouseInput = mkOption {
        description = "Warp the cursor back to where it was after using a non-mouse input to move it, and then returning back to mouse.";
        type = types.bool;
        default = false;
      };
      zoomDisableAa = mkOption {
        description = "disable antialiasing when zooming, which means things will be pixelated instead of blurry";
        type = types.bool;
        default = false;
      };
    };

    ecosystem = {
      noUpdateNews = mkOption {
        description = "disable the popup that shows up when you update hyprland to a new version.";
        type = types.bool;
        default = false;
      };
      noDonationNag = mkOption {
        description = "disable the popup that shows up twice a year encouraging to donate.";
        type = types.bool;
        default = false;
      };
      enforcePermissions = mkOption {
        description = "whether to enable [permission control](../Permissions).";
        type = types.bool;
        default = false;
      };
    };
  };
}
