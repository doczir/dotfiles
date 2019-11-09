# Be nice to OSX
if [[ "$OSTYPE" == "darwin"* ]]; then
  # load env from environment.d in place of systemd
  set -a
  for envfile in $HOME/.config/environment.d/*.conf; do
    source $envfile
  done
  set +a

  source /etc/zprofile
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
fi

# move zsh to config folder
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

# source machine specific environments
[[ -f "$ZDOTDIR"/local.env ]] && source "$ZDOTDIR"/local.env

