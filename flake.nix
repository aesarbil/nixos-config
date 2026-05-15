{
  description = "NixOS - ThinkPad X260 (aesarbil)";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url                    = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-desktop = {
      url = "github:aaddrick/claude-desktop-debian";
    };
  };
  outputs = { self, nixpkgs, home-manager, claude-desktop }: {
    nixosConfigurations.thinkpad-x260 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs   = true;
          home-manager.useUserPackages = true;
          home-manager.users.aesarbil  = import ./modules/home.nix;
        }
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ claude-desktop.overlays.default ];
          nixpkgs.config.allowUnfreePredicate = pkg:
            builtins.elem (pkgs.lib.getName pkg) [ "claude-desktop" ];
          environment.systemPackages = [ pkgs.claude-desktop ];
        })
      ];
    };
  };
}
