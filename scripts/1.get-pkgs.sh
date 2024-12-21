#!/bin/bash

[[ -d $WorkDir/pkg ]] || sudo mkdir -p $WorkDir/pkg
[[ ! -f $WorkDir/pkg/packages.list ]] || sudo rm -rf $WorkDir/pkg/packages.list
pacman -Qq | sudo tee -a $WorkDir/pkg/packages.list &>/dev/null
