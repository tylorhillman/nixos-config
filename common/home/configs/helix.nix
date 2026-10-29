{ host, ... }:

let
  flake = ''(builtins.getFlake (toString ./.))'';
  nixosOpts = "${flake}.nixosConfigurations.${host.name}.options";
    
in {

    xdg.configFile."helix/config.toml".text = ''
      [editor.lsp]
      display-inlay-hints = true
      '';

    xdg.configFile."helix/languages.toml".text = ''
      [language-server.nixd]
      command = "nixd"

      [language-server.nixd.config.nixd.options.nixos]
      expr = "${nixosOpts}"

      [language-server.nixd.config.nixd.options.home-manager]
      expr = "${nixosOpts}.home-manager.users.type.getSubOptions []"  
      '';
  }
