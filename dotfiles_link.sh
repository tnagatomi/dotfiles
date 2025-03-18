#!/bin/sh
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

mkdir -p ~/.config

ln -sf ~/dotfiles/.config/starship.toml ~/.config/starship.toml

mkdir -p ~/.config/ghostty
ln -sf ~/dotfiles/.config/ghostty/config ~/.config/ghostty/config

mkdir -p ~/.config/zellij
ln -sf ~/dotfiles/.config/zellij/config.kdl ~/.config/zellij/config.kdl
