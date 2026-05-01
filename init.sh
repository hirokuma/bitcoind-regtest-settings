#!/bin/bash

DAEMON='bitcoind -regtest'
CLI='bitcoin-cli -regtest'
WALLET_NAME='test'
NEWBLOCKS=101

if [ -f ".env" ]; then
    source .env
fi

$CLI stop
sleep 1
rm -rf $HOME/.bitcoin/regtest
$DAEMON -daemon
sleep 1
while :
do
    ibd=$($CLI getblockchaininfo | jq .initialblockdownload)
    if [ "$ibd" == "true" ]; then
        break
    fi
    echo -n "."
    sleep 1
done
echo

$CLI createwallet "$WALLET_NAME"
sleep 1
./generate.sh $NEWBLOCKS
