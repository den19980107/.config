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
set fish_function_path /Users/den19980107/.config/fish/functions/theme-pure/functions/ $fish_function_path
source /Users/den19980107/.config/fish/functions/theme-pure/conf.d/pure.fish


### SETTING THE STARSHIP PROMPT ###
starship init fish | source


### kubectl
kubectl completion fish | source
export KUBE_EDITOR=nvim
# alias kubectl="kubecolor"

### GO
export GOPATH=/Users/den19980107/go
export PATH="$GOPATH/bin:$PATH"

### Picgo
export PATH="/user/local/bin/picgo:$PATH"

### Cargo
set PATH $HOME/.cargo/bin $PATH

### Esp32 Cargo
export LIBCLANG_PATH="/Users/den19980107/.espressif/tools/xtensa-esp32-elf-clang/esp-15.0.0-20221201-aarch64-apple-darwin/esp-clang/lib/"
export PATH="/Users/den19980107/.espressif/tools/xtensa-esp32-elf-gcc/8_4_0-esp-2021r2-patch3-aarch64-apple-darwin/bin/:/Users/den19980107/.espressif/tools/xtensa-esp32s2-elf-gcc/8_4_0-esp-2021r2-patch3-aarch64-apple-darwin/bin/:/Users/den19980107/.espressif/tools/xtensa-esp32s3-elf-gcc/8_4_0-esp-2021r2-patch3-aarch64-apple-darwin/bin/:$PATH"

### Python2
export PATH="$HOME/.pyenv/shims:$PATH"

### Advantech Worker RawData Checker
export PATH="/Users/den19980107/Documents/playground/go-playground/worker-raw-data-correctness-checker:$PATH"

### Esp32 idf (type get_idf at command line to use idf.py)
alias get_idf='. $HOME/esp/esp-idf/export.fish'

source /Users/den19980107/.docker/init-fish.sh || true # Added by Docker Desktop
