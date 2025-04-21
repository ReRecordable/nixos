{ 
  description = "NixOS Configurations";
  
  inputs = { 
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    jovian.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:NotAShelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    zen.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = {self, nixpkgs, jovian, nvf, ... }@inputs: { 
    nixosConfigurations = {
      # Disable this for now, going to redo the config.
      # "nix-deck" = nixpkgs.lib.nixosSystem {
      #    system = "x86_64-linux";
      #    specialArgs = { inherit inputs; };
      #    modules = [ ./dev/deck/configuration.nix jovian.nixosModules.jovian ];
      # };
      "nix5590" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = { inherit inputs; };
	modules = [ ./Devices/5590/configuration.nix ];
      };
      "nixos" = nixpkgs.lib.nixosSystem { 
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./Devices/surface/configuration.nix nvf.nixosModules.default ];
      };
    };
  };
}
