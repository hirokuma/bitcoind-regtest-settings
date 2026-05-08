#!/bin/bash

DAEMON='bitcoind -regtest'
CLI='bitcoin-cli -regtest'

if [ -f ".env" ]; then
    source .env
fi

if [[ $# == 0 ]]; then
  echo "Help:"
  echo "    $0 start: start bitcoin node"
  echo "    $0 generate <NUM>: generatetoaddress"
  exit 1
elif [[ $# == 1 ]] && [[ "$1" == "start" ]]; then
  $DAEMON -daemon
  sleep 3
  $CLI loadwallet $WALLET_NAME
elif [[ $# == 1 ]] && [[ "$1" == "generate" ]]; then
  $CLI generatetoaddress 1 `$CLI getnewaddress`
elif [[ $# == 2 ]] && [[ "$1" == "generate" ]]; then
  $CLI generatetoaddress $2 `$CLI getnewaddress`
else
  $CLI $@
fi
