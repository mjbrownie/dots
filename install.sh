#!/bin/bash
echo Moving old .vim.stuff
mv ~/.vimrc ~/.vimrc.pre.plugged
mv ~/.vim ~/.vim.pre.plugged

echo Adding Plugged
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo done . Run :PlugInstall! 
