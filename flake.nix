{
  description = "tylorhillman nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, ... }@inputs:
    let

      deskDir = ./hosts/desktop;
      laptopDir = ./hosts/laptop;
      commonDir = ./common/modules;

    in {
      # Desktop Configuration
      nixosConfigurations.niikusu-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          "${deskDir}/configuration.nix"
          "${commonDir}/packages.nix"
        ];
      };

      # Laptop Configuration
      nixosConfigurations.niikusu-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          "${laptopDir}/configuration.nix"
          "${commonDir}/packages.nix"
        ];
      };
  };
}
