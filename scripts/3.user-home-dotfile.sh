#!/bin/bash

[[ -d $WorkDir/dotfiles ]] || sudo mkdir -p $WorkDir/dotfiles

cd ~
sudo cp -r ${UserHomeDot[@]} $WorkDir/dotfiles/