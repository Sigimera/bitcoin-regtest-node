#!/bin/bash
######################################
# Configuration
######################################
BR_START="bitcoind -regtest -daemon"
BR_STOP="bitcoin-cli -regtest stop"
BR="bitcoin-cli -regtest"
BR_OPTS="-printtoconsole -externalip=127.0.0.1"

SLEEP_TIME=7

LOG_FILE="/tmp/bitcoind.log"
PID_FILE="/tmp/bitcoind.pid"

REGTEST_DIR="${HOME}/.bitcoin/regtest/"

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
  echocyan "COMMAND";echo
  echocyan "[b|bootstrap]        ... Initialize a new private blockchain (regtest) and mine first 50 BTC.";echo
  echocyan "[s|simulate] <addr>  ... Transfer a random amount of money in a random amount of transactions to the address <addr>.";echo
  echocyan "[m|mine]             ... Mine one block and include all transactions that are currently in the memory pool, if possible.";echo
}

case "$1" in
    b|bootstrap)
      terminateBitcoind
      purgingBlockchain
      startBitcoind
      miningFirstBTC
    ;;
    m|mine)
      generateBlock
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
