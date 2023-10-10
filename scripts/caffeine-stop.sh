#!/bin/bash

check_caffeine_running() {
    pgrep -x caffeine >/dev/null
}

if check_caffeine_running; then
    echo "Caffeine is running. Stopping now..."
    pkill -x caffeine
else
    echo "Caffeine is not running."
fi
