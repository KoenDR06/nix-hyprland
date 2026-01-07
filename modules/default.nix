{lib, ...}: let
  inherit (lib) mkOption types mkEnableOption;
in {
  imports = [
    ./options
    ./dots
  ];

  options = {
    nix-hyprland = {
      username = mkOption {type = types.str;};
      enable = mkEnableOption "Enable the dotfiles";
    };
  };
}
