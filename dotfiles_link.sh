#!/bin/sh
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

if [ -d ~/dotfiles/.config ]
then
    mkdir -p ~/dotfiles/.config
fi

if [ -d ~/dotfiles/.config/nvim ]
then
    mkdir -p ~/dotfiles/.config/nvim
fi

ln -sf ~/dotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua
