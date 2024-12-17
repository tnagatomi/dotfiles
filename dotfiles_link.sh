#!/bin/sh
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.wezterm.lua ~/.wezterm.lua

if [ -d ~/dotfiles/.config ]
then
    mkdir -p ~/dotfiles/.config
fi

ln -sf ~/dotfiles/.config/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/.config/starship.theme.toml ~/.config/starship.theme.toml

src_dir="${HOME}/dotfiles/.config/nvim"
dest_dir="${HOME}/.config/nvim"
mkdir -p "$dest_dir"
find "$src_dir" -type f | while read src_file; do
  dest_file="$dest_dir/$(grealpath --relative-to="$src_dir" "$src_file")"

  mkdir -p "$(dirname "$dest_file")"

  ln -sf "$src_file" "$dest_file"
done
