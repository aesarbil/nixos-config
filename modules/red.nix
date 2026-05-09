# =============================================================================
# Red
# =============================================================================
{ config, pkgs, ... }:
{
  networking.hostName                      = "thinkpad-x260";
  networking.networkmanager.enable         = true;
  networking.networkmanager.wifi.powersave = false;
}
