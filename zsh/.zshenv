# load envs in place of systemd if necessary
if [[ "$OSTYPE" == "darwin"*  || "$TERM" == "linux" ]]; then
  # load env from environment.d in place of systemd
  set -a
  for envfile in $HOME/.config/environment.d/*.conf; do
    source $envfile
  done
  set +a
fi

# Be nice to OSX
if [[ "$OSTYPE" == "darwin"* ]]; then
  [[ -f /etc/zprofile ]] && source /etc/zprofile
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
fi

# decluter home
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}"/zsh

