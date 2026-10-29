{ ... }:

{
  xdg.configFile."fish/conf.d/gpg.fish".text = ''
    set -gx GPG_TTY (tty)
    gpg-connect-agent --quiet updatestartuptty /bye >/dev/null
  '';
}
