#!/bin/bash
######################################
# Configuration
######################################
BR="bitcoind -regtest"
BR_OPTS="-printtoconsole -externalip=127.0.0.1"

SLEEP_TIME=7

LOG_FILE="/tmp/bitcoind.log"
PID_FILE="/tmp/bitcoind.pid"

REGTEST_DIR="${HOME}/.bitcoin/regtest/"
DB_NAME="regtest"

DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LIB_DIR=${DIR}/lib

######################################
# Include dependencies
######################################
source ${LIB_DIR}/colors.sh
source ${LIB_DIR}/bitcoind.sh
source ${LIB_DIR}/spending.sh

function cmd_help() {
      echocyan "USAGE: $0 COMMAND";echo;echo
      echocyan " [b|bootstrap]        ... Initialize a new private blockchain (regtest) and mine first 50 BTC.";echo
      echocyan " [s|simulate] <addr>  ... Transfer a random amount of money in a random amount of transactions to the address <addr>.";echo
}

case "$1" in
    b|bootstrap)
      terminateBitcoind
      purgingBlockchain
      startBitcoind
      miningFirstBTC
    ;;
    s|simulate)
      if [ -z "$2" ]; then
        cmd_help; exit
      elif [ -z "$3" ]; then
        donateRandomAmount $2 $(randomInteger)
        generateBlock
      else
        donateRandomAmount $2 $3
        generateBlock
      fi
    ;;
    *)
      cmd_help; exit
    ;;
esac
