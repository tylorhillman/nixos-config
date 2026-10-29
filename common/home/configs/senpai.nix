{ ... }:

{

  xdg.configFile."senpai/senpai.scfg".text = ''
    address "irc.libera.chat:6697"
    nickname tylorhillman_
    username tylorhillman_
    password-cmd pass show irc/libera
  '';
  
}
