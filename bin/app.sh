#!/usr/bin/env bash

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" 1>/dev/null && pwd )
PSGI_SCRIPT=$SCRIPTDIR/app.psgi
PORT=5555

plackup -p $PORT -s Starman $PSGI_SCRIPT
