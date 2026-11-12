{ ... }:

let
  path = .././wallpapers;
  file = "/midnight-miami.png";
  background = path + file;

in {
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "${background}";
          fit_mode = "cover";
        }
      ];
    };
  };
}
