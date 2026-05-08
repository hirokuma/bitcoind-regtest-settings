# Bitcoin Regtest

* 最初に `init.sh` か `init-with-feerate.sh` で準備
* 2回目以降は `regtest.sh start` で開始して `regtest.sh` でCLI操作
* ブロックを自動生成させたいなら `generate.sh auto`

## init.sh

* bitcoind停止
* 前環境を削除
* ウォレット作成
* ブロック生成

## init-with-feerate.sh

`init.sh`からfeerateを変更

## regtest.sh

`bitcoin-cli $@`

### start

```bash
bitcoind -daemon
bitcoin-cli loadwallet
```

### ブロック生成

`generate.sh` でよいのだが

#### generate

`bitcoin-cli generatetoaddress 1 <ADDR>`

#### generate NUM

`bitcoin-cli generatetoaddress NUM <ADDR>`

## generate.sh

ブロック生成

### 1ブロック

```bash
./generate.sh
```

### 複数ブロック

```bash
./generate.sh 100
```

### 定期的に作成

```bash
./generate.sh auto
```
