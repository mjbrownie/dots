#!/bin/bash
mv ~/.vimrc ~/.vimrc.pre.plugged
mv ~/.vim ~/.vim.pre.plugged

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
