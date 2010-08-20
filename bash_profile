source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config

if [ -f ~/.bash/dir_colors ]; then
    export LS_OPTIONS='--color=auto'
    eval `dircolors  ~/.bash/dir_colors`
fi

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ -f ~/.localrc ]; then
  . ~/.localrc
fi


PATH=/usr/local/magicwrap/bin:$PATH


