#!/bin/bash

DIR_TARGET="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIR_LINK="$HOME"
FILE_NAME=".zshrc"

PATH_TARGET="$DIR_TARGET/$FILE_NAME"
PATH_LINK="$DIR_LINK/$FILE_NAME"

echo $PATH_TARGET $PATH_LINK

if [ -f $PATH_LINK ]; then
	cp "$PATH_LINK" "${PATH_LINK}_backup_$(date '+%Y%m%d%H%M%S')"
fi

ln -sf "$PATH_TARGET" "$PATH_LINK"
