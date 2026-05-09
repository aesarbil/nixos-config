# =============================================================================
# Usuario
# =============================================================================

{ config, pkgs, ... }:

{
  users.users.aesarbil = {
    isNormalUser = true;
    description  = "Antonio";
    extraGroups  = [ "networkmanager" "wheel" "video" "audio" "input" ];
    shell        = pkgs.fish;
  };
}
