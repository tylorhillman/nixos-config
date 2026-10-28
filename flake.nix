{
  description = "tylorhillman nix flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
};
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let

      deskDir = ./hosts/desktop;
      laptopDir = ./hosts/laptop;
      commonDir = ./common/modules;
      homeDir = ./common/home;

      commonModules = map (file: commonDir + "/${file}") (
        builtins.filter (file: nixpkgs.lib.hasSuffix ".nix" file) (
            builtins.attrNames (builtins.readDir commonDir)
        )
    );

    in {
      # Desktop Configuration
      nixosConfigurations.niikusu-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          "${deskDir}/configuration.nix" # Host specific configs
           home-manager.nixosModules.home-manager # home-manager specific configs
           {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.tylor = "${homeDir}/tylor.nix";
          }
        ] ++ commonModules; # common configs for all flakes
      };

      # Laptop Configuration
      nixosConfigurations.niikusu-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          "${laptopDir}/configuration.nix" # Host specific configs
           home-manager.nixosModules.home-manager # home-manager specific configs
           {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.tylor = "${homeDir}/tylor.nix";
          }
        ] ++ commonModules; # common configs for all flakes
    };
  };
}
