export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
alias ibrew='arch -x86_64 /usr/local/bin/brew'



export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan



# THEME PURE #
set fish_function_path $HOME/.config/fish/functions/theme-pure/functions/ $fish_function_path
source $HOME/.config/fish/functions/theme-pure/conf.d/pure.fish


### SETTING THE STARSHIP PROMPT ###
starship init fish | source


### kubectl
kubectl completion fish | source
export KUBE_EDITOR=nvim
# alias kubectl="kubecolor"

### GOENV
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
