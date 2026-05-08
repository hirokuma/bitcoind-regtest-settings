#!/bin/bash

DAEMON='bitcoind -regtest'
CLI='bitcoin-cli -regtest'
WALLET_NAME='test'
NEWBLOCKS=101

# トランザクション数と生成回数の設定
TX_COUNT=30
BLOCKS=20

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

# 複数のfeeレベルを作成（1〜30 sat/vB 相当）
echo "Sending $TX_COUNT transactions with varying fees..."
for i in $(seq 1 $TX_COUNT); do
    DEST=$($CLI getnewaddress)
    TXID=$($CLI -named sendtoaddress address="$DEST" amount=0.0001 fee_rate="$i")
    echo "Sent $i $TXID"
done

# 少し時間を置く（mempoolに反映されるまでのため）
sleep 2

# ブロックを複数生成してTXを順次承認
echo "Mining $BLOCKS blocks..."
for i in $(seq 1 $BLOCKS); do
    echo "generate block $i"
    ./generate.sh
    sleep 0.2
done

# estimatesmartfee を試す
echo "Estimating fee for confirmation within 2 blocks..."
$CLI estimatesmartfee 2
