#!/bin/sh
ln -sf ~/dotfiles/.zshrc ~/.zshrc
mkdir -p ~/dotfiles/.local/share/zinit/completions
ln -sf ~/dotfiles/.local/share/zinit/completions/_zellij ~/.local/share/zinit/completions/_zellij

ln -sf ~/dotfiles/.vimrc ~/.vimrc

mkdir -p ~/dotfiles/.config

ln -sf ~/dotfiles/.config/starship.toml ~/.config/starship.toml

mkdir -p ~/dotfiles/.config/ghostty
ln -sf ~/dotfiles/.config/ghostty/config ~/.config/ghostty/config

mkdir -p ~/dotfiles/.config/zellij
ln -sf ~/dotfiles/.config/zellij/config.kdl ~/.config/zellij/config.kdl
