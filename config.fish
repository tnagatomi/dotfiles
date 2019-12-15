alias ocaml="rlwrap ocaml"
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

status --is-interactive; and source (anyenv init -|psub)
