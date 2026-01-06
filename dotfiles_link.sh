#!/bin/sh
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.wezterm.lua ~/.wezterm.lua

mkdir -p ~/.config

ln -sf ~/dotfiles/.config/starship.toml ~/.config/starship.toml

mkdir -p ~/.config/ghostty
ln -sf ~/dotfiles/.config/ghostty/config ~/.config/ghostty/config
