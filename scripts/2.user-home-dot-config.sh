#!/bin/bash

[[ -d $WorkDir/config ]] || sudo mkdir -p $WorkDir/config

cd ~/.config
sudo cp -r ${UserHomeConfig[@]} $WorkDir/config/
