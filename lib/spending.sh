######################################
# Donate to address
######################################
function donateRandomAmount() {
  if [ -z "$1" ]; then
    return
  fi
  if [ -z "$2" ]; then
    LOOP=1
  else
    LOOP=$2
  fi

  echogreen "[ADDRESS] Transferring ${LOOP} random amounts to address '${1}'"; echo
  for i in `seq 1 ${LOOP}`; do
    AMOUNT=0$(echo "scale=8; ${RANDOM} / 100000.0" | bc)
    TRX=$(${BR} sendfrom "${WALLET_ACCOUNT}" $1 ${AMOUNT})
    if [ "$?" != "0" ]; then exit; fi
    echoyellow "\t|-> Transferred ${AMOUNT} BTC in trx '${TRX}'";echo
  done
}

function generateBlock() {
  echocyan "[INFO] Generating new block!"; echo
  ${BR} generate 1

  blk_hash=$(${BR} getbestblockhash)
  blk=$(${BR} getblock $blk_hash)
  txsize=$(ruby -rjson -e "puts JSON.parse('$blk')['tx'].size") 
  echocyan "\t|-> Block Hash: ${blk_hash}";echo
  echocyan "\t|-> TRX Number: ${txsize}";echo
}

function showWalletBalance() {
  BALANCE=$(${BR} getbalance)
  echocyan "[WALLET] Current balance: \e[1m\e[7m${BALANCE} BTC\e[0m"; echo
}

function randomInteger() {
  echo $((RANDOM%10+1))
}