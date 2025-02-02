# Which tx in block 257,343 spends the coinbase output of block 256,128?

TXID=$(bitcoin-cli getblock "$(bitcoin-cli getblockhash 256128)" 2 | jq -r '.tx[0].txid' )
bitcoin-cli getblock "$(bitcoin-cli getblockhash 257343)" 2 |jq -r '.tx[] | select(any(.vin[].txid; . == "'$TXID'")) | .txid'

