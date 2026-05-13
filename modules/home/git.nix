{ config, pkgs, ... }:
{
  programs.git = {
    enable   = true;
    settings = {
      user.name      = "aesarbil";
      user.email     = "aesarbil@gmail.com";
      safe.directory = "/etc/nixos";
      alias = {
        gs = "status";
        ga = "add -A";
        gp = "push";
      };
    };
  };
}
