#!/bin/bash

# To be used to prevent the system from sleeping

check_caffeine_installed() {
    dpkg -l | grep -q caffeine
}

check_caffeine_running() {
    pgrep -x caffeine >/dev/null
}

if ! check_caffeine_installed; then
    echo "Caffeine is not installed. Installing now..."
    sudo apt-get update
    sudo apt-get install -y caffeine
else
    echo "Caffeine is already installed."
fi

if ! check_caffeine_running; then
    echo "Caffeine is not running. Starting now..."
    caffeine &
else
    echo "Caffeine is already running."
fi
