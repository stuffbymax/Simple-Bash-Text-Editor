#!/bin/bash

# Path to your .vimrc file
vimrc_path=~/.vimrc

# Function to add or update a setting in .vimrc
update_vimrc() {
    if grep -q "$1" "$vimrc_path"; then
        sed -i "s/^.*$1.*$/$1/" "$vimrc_path"
    else
        echo "$1" >> "$vimrc_path"
    fi
}

# Add or update settings in .vimrc
update_vimrc "set nocompatible"
update_vimrc "filetype on"
update_vimrc "filetype plugin on"
update_vimrc "syntax on"
update_vimrc "set number"
update_vimrc "set cursorline"
update_vimrc "set cursorcolumn"
update_vimrc "set shiftwidth=4"
update_vimrc "set tabstop=4"
update_vimrc "set expandtab"
update_vimrc "set nobackup"
update_vimrc "set scrolloff=10"
update_vimrc "set nowrap"
update_vimrc "set incsearch"
update_vimrc "set ignorecase"
update_vimrc "set smartcase"
update_vimrc "set showcmd"
update_vimrc "set showmode"
update_vimrc "set showmatch"
