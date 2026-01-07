{lib, ...}: let
  inherit (lib) mkOption types;
  # v0.52.1
in {
  options.nix-hyprland = {
    dwindle = {
      pseudotile = mkOption {type = types.bool;};
      preserveSplit = mkOption {type = types.bool;};
    };

    master = {
      newStatus = mkOption {type = types.enum ["master" "slave" "inherit"];};
    };

    execOnce = mkOption {
      type = types.listOf types.str;
      default = [];
    };

    env = mkOption {
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {type = types.str;};
          value = mkOption {type = types.str;};
        };
      });
    };

    windowrules = mkOption {
      type = types.listOf types.str;
      default = [];
    };

    workspaces = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };
}
