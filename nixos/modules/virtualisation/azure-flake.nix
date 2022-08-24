{
  description = "NixOS configuration for azure vm";

  inputs.nixpkgs.url = "github:kfollesdal/nixpkgs/update-azure-image";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.azure = nixpkgs.lib.nixosSystem {
      modules = [ {
          system.stateVersion = "22.11";
          nixpkgs.localSystem.system = "x86_64-linux";

          nix.settings = {
            experimental-features = [ "nix-command" "flakes" ];
          };


    users.users.odin = {
      description = "Azure client user";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYW+mY2ksTSVai2pnf5fScvcSFO+kMZ006jkQW3tguu kristoffer.follesdal@eviny.no"
      ];
    };

    } ] ++ [
          "${nixpkgs}/nixos/modules/virtualisation/azure.nix"
        ];
    };
  };
}