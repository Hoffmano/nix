{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-unstable-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    nixvim.url = "github:nix-community/nixvim/nixos-24.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      host = "server";
      system = "x86_64-linux";
      unstable-small-pkgs = import inputs.nixos-unstable-small { inherit system; };
      xdphOverlay = _: _: {
        inherit (unstable-small-pkgs) xdg-desktop-portal-hyprland;
      };
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [ xdphOverlay ];
      };
    in
    {
      nixosConfigurations = {
        nixos = inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ./hosts/${host}-os.nix
          ];
        };
      };

      homeConfigurations.hoffmano = inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [
          ./hosts/${host}-home.nix
          inputs.stylix.homeManagerModules.stylix
          inputs.nixvim.homeManagerModules.nixvim
        ];
      };
    };
}
