#!/bin/bash

query=$(rofi -dmenu -p "Search the web")

if [ -n "$query" ]; then
    firefox --search "$query"
fi

