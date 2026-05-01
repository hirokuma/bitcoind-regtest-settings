#!/bin/bash

CLI='bitcoin-cli -regtest'
PERIOD=120

if [ -f ".env" ]; then
    source .env
fi

NUM=$1
if [ "$NUM" == "" ]; then
    NUM=1
    elif [ "$NUM" == "auto" ]; then
    while :
    do
        date
        $CLI generatetoaddress 1 `$CLI getnewaddress`
        sleep $PERIOD
    done
fi
$CLI generatetoaddress $NUM `$CLI getnewaddress`
