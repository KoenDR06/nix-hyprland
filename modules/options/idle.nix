{lib, ...}: let
  inherit (lib) mkOption types;
  # v0.52.1
in {
  options.nix-hyprland = {
    sleep = {
      lockCommand = mkOption {type = types.str;};

      listeners = mkOption {
        type = types.listOf (types.submodule {
          options = {
            timeout = mkOption {type = types.ints.positive;};
            onTimeout = mkOption {type = types.str;};
            onResume = mkOption {
              type = types.str;
              default = "";
            };
            ignoreInhibit = mkOption {
              type = types.bool;
              default = false;
            };
          };
        });
      };
    };
  };
}
