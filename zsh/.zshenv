# setup xdg directory environments
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CONFIG_DIRS=/etc/xdg

# decluter home
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export HISTFILE="$XDG_DATA_HOME"/zsh/histroy
[ ! -d "$XDG_CACHE_HOME"/zsh ] && mkdir "$XDG_CACHE_HOME"/zsh
export ZSH_COMPDUMP="$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION
[ ! -d "$XDG_CACHE_HOME"/nv ] && mkdir "$XDG_CACHE_HOME"/nv
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export LESSHISTFILE=-
export NVM_DIR="$XDG_DATA_HOME"/nvm
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# source machine specific environments
[[ -f $ZDOTDIR/local.env ]] && source $ZDOTDIR/local.env
