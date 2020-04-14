export PATH=$HOME/.local/bin:$HOME/.gem/ruby/2.7.0/bin:$PATH

# Setup Nix (needs to be done before sourcing oh-my-zsh, prezto etc., to make sure commands are available for plugins)
if [ -f "$HOME"/.nix-profile/etc/profile.d/nix.sh ]; then
 source $HOME/.nix-profile/etc/profile.d/nix.sh
 NIX_PATH=nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs
fi

#[[ $TERM == "alacritty" ]] && exec tmux -f "${XDG_CONFIG_HOME}/tmux/tmux.conf" -u

### Added by Zplugin's installer
source "$ZDOTDIR/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zplugin installer's chunk

export EDITOR=nvim

zinit ice svn multisrc"{completion,directories,functions,history,key-bindings,misc,spectrum,termsupport}.zsh" pick"/dev/null"
zinit snippet OMZ::lib

zinit ice wait as"completion" lucid
zinit snippet OMZ::plugins/docker/_docker

zinit ice wait as"completion" lucid
zinit snippet OMZ::plugins/docker-compose/_docker-compose

zinit ice wait lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice wait lucid
zinit load rupa/z

zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit load spwhitt/nix-zsh-completions

zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" atload"export FAST_HIGHLIGHT[whatis_chroma_type]=0"
zinit light zdharma/fast-syntax-highlighting

zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
#[ -s "$NVM_DIR/alias/default" ] && export PATH="$NVM_DIR/versions/node/$(<$NVM_DIR/alias/default)/bin:$PATH"
alias nvm="unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; nvm $@"

alias zshrc="nvim $ZDOTDIR/.zshrc"
alias ls="exa"
alias l="exa -a"
alias ll="exa -lgh"
alias la="exa -lagh"
alias lt="exa -lagh --sort modified"
alias lg="exa -lagh --git"
alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'
alias cat="bat -p"

function tmw {
  tmux split-window -dh "$*"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
 alias telnet="nix run nixpkgs.telnet -c telnet"
fi

alias nix-shell='nix-shell --run zsh'

export LESS="-F -g -i -M -R -S -w -X -z-4"

export SDKMAN_DIR="/home/rdoczi/.sdkman"
[[ -s "/home/rdoczi/.sdkman/bin/sdkman-init.sh" ]] && source "/home/rdoczi/.sdkman/bin/sdkman-init.sh"

export SBT_OPTS="-Dsbt.turbo=true"

setopt auto_cd
setopt multios
setopt prompt_subst

eval "$(starship init zsh)"
#eval "$(direnv hook zsh)"
export RD_TOOLBOX_DIR="$HOME/Projects/rd-toolbox/"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/rdoczi/.local/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/home/rdoczi/.local/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/rdoczi/.local/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/rdoczi/.local/opt/google-cloud-sdk/completion.zsh.inc'; fi
