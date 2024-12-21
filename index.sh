#!/bin/bash

export deps="/arch/deps"
source "$deps/env.sh"

case $1 in
    "update")
        bash "$deps/update.sh"
        ;;
    "push")
        bash "$deps/push.sh"
        ;;
    *)
        bash "$deps/update.sh"
        bash "$deps/push.sh"
        ;;
esac