{lib, ...}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./options
    ./dots
  ];

  options = {
    nix-hyprland = {
      username = mkOption {type = types.str;};
    };
  };
}
