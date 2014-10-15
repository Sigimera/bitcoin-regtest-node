# bitcoin-regtest-node #

This repository contains instructions, with related helper code, that allows you to run your own blockchain locally. Get started pretty fast and develop your own Bitcoin application.

## Quickstart ##

### Installation ###

Installation of the official bitcoin core implementation from https://bitcoin.org/en/download

    ~$ BITCOIN_VERSION=0.9.3 # You may want to change that the current version.
    ~$ wget https://bitcoin.org/bin/${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-linux.tar.gz
    ~$ tar xf bitcoin-${BITCOIN_VERSION}-linux.tar.gz
    # Change 64 to 32 for 32bit architecture
    ~$ mv bitcoin-${BITCOIN_VERSION}-linux/bin/64/* /usr/local/bin 
    
### Get your first Bitcoin ###

    # For testing purpose we want verbose output
    ~$ bitcoind -regtest -printtoconsole
    ... # Lot of output here
    
    # Switch to new console and let the bitcoind running.
    # We generate 101 new blocks (starting from the genesis block),
    # in order to be able to access the first one and get 50 BTC.
    ~$ bitcoind -regtest setgenerate 101
    ... # Wait until all blocks are generated, ~1 minute
    ~$ bitcoind -regtest getbalance
    50.00000000 # <= You should see that or at least a number bigger then zero.

**Congratulations!** You have now your first BTC that you can spent. 

Where to go from here? Please read further how to spent this BTC and how to make the whole a little bit more effective, with less typing and more automated.

### Preparing your working environment ###

    # We don't want to type each time `bitcoind -regtest`.
    # The command `br` is easier to type and easy to remember (the beginning letters of the command).
    ~$ echo 'alias br="bitcoind -regtest"' >> ~/.bashrc; source ~/.bashrc
    
    
## TODO ##

* Provide scripts that automate the whole node setup and spending process, e.g. by simulated random transfers.
* Explain how the blockchain could be stored in a SQL database and accessed via your application.
* Describe how the node can be virtualized with vagrant or docker.

## Help this project ##

Please help us to extend and improve this project.

1. Fork it!
2. Make your changes.
3. Create a pull request.


Please donate if you want to motivate us to improve this project even further.

[1LKzkn4CfktnSXDMNt856KqHcjMdTCp57S](bitcoin:1LKzkn4CfktnSXDMNt856KqHcjMdTCp57S?label=bitcoin-regtest-node)<br/>
If clicking on the line above does not work, use this payment info:<br/>
**Pay to:**  `1LKzkn4CfktnSXDMNt856KqHcjMdTCp57S` <br/>
**Message:** Donation for bitcoin-regtest-node open source project.

