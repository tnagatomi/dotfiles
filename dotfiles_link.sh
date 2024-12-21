#!/bin/sh
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.wezterm.lua ~/.wezterm.lua

mkdir -p ~/dotfiles/.config

ln -sf ~/dotfiles/.config/starship.toml ~/.config/starship.toml
