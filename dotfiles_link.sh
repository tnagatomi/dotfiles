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
