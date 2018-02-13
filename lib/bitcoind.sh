######################################
# Stopping previous running instance
######################################
function terminateBitcoind() {
  if [ -f ${PID_FILE} ]; then
    echoyellow "[WARN] Found previously started instance. Killing '$(<${PID_FILE})'!"; echo
    kill -9 $(<${PID_FILE}) 2> /dev/null
    rm -f ${PID_FILE} ${LOG_FILE}
    # Waiting until bitcoind has stopped
    sleep ${SLEEP_TIME}
  fi
}

######################################
# Cleaning up old blockchain
######################################
function purgingBlockchain() {
  echoyellow "[WARN] Deleting directory '${REGTEST_DIR}' in "
  for i in `seq 5 -1 1`; do
    echored  $i
    sleep 1
    echo -n " "
  done
  rm -rf ${REGTEST_DIR}
  echo
}

######################################
# Starting a fresh bitcoin daemon instance
######################################
function startBitcoind() {
  ${BR_STOP} &
  ${BR_START} &
  ${BR} ${BR_OPTS} &> ${LOG_FILE} &
  echo $! > ${PID_FILE}

  echogreen "[DAEMON] Starting '${BR} ${BR_OPTS}' with PID '$(<${PID_FILE})'"; echo
  echogreen "[DAEMON] Logfile under '${LOG_FILE}'"; echo

  # Waiting until bitcoind has started
  sleep ${SLEEP_TIME}
}

######################################
# Mining first 101 Bitcoin in order to
# be able to access the first one.
######################################
function miningFirstBTC() {
  echocyan "[MINING] Mining Bitcoin. Please be patient for ~1 minute"; echo
  ${BR} generate 101

  BALANCE=$(${BR} getbalance)
  echocyan "[WALLET] Your current balance: \e[1m\e[7m${BALANCE} BTC\e[0m"; echo
}

