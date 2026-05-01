# Bitcoin Regtest

## init.sh

* bitcoind停止
* 前環境を削除
* ウォレット作成
* ブロック生成

## with-feerate.sh

`init.sh`からfeerateを変更

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
