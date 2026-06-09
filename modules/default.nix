{lib, config, ...}: let
  inherit (lib) types mkOption;
  inherit (hyprLib) categoryToLua minimizeCategory;

  hyprLib = import ./types.nix { inherit lib; };

  cfg = config.nix-hyprland.config;
in {
  imports = [
    ./options.nix
    ./animations.nix
  ];

  options = {
    nix-hyprland.result = mkOption {
      type = types.attrs;
      readOnly = true;
    };
  };

  config = let
  in {
    nix-hyprland.result = minimizeCategory cfg;
  };
}
