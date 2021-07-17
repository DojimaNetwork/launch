#!/usr/bin/env sh

set -x #echo on

if [ -z "$1" ]
  then
    echo "Address is required as argument"
  exit 1
fi

ADDRESS=$1
BULLDOG_DIR=${BULLDOG_DIR:-~/.bor}
DATA_DIR=$BULLDOG_DIR/data

bor --datadir $DATA_DIR \
  --port 30303 \
  --http --http.addr '0.0.0.0' \
  --http.vhosts '*' \
  --http.corsdomain '*' \
  --http.port 8545 \
  --ipcpath $DATA_DIR/bor.ipc \
  --http.api 'eth,net,web3,txpool,bor' \
  --networkid '137' \
  --syncmode 'full' \
  --miner.gaslimit '20000000' \
  --miner.gastarget '20000000' \
  --txpool.nolocals \
  --txpool.accountslots '128' \
  --txpool.globalslots '20000'  \
  --txpool.lifetime '0h16m0s' \
  --keystore $BULLDOG_DIR/keystore \
  --unlock $ADDRESS \
  --password $BULLDOG_DIR/password.txt \
  --allow-insecure-unlock \
  --nodiscover --maxpeers 1 \
  --metrics \
  --pprof --pprof.port 7071 --pprof.addr '0.0.0.0' \
  --mine
