{ hyprLib, lib, ...}: let
  inherit (lib) types mkOption;

  inherit (hyprLib.types) windowrule layerrule workspacerule;
in {
  options.hyprnix.hyprland = {
    windowrules = mkOption {
      type = types.attrsOf windowrule;
      default = {};
    };
    layerrules = mkOption {
      type = types.attrsOf layerrule;
      default = {};
    };

    workspacerules = mkOption {
      type = types.attrsOf workspacerule;
      default = {};
    };
  };
}
