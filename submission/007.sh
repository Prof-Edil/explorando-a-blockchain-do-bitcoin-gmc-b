# Only one single output remains unspent from block 123,321. What addrress was it sent to?

BLOCK_NUMBER=123321

CURRENT_BLOCK=$(bitcoin-cli getblock "$(bitcoin-cli getblockhash $BLOCK_NUMBER )" 2)
mapfile -t TX_LIST < <(  echo $CURRENT_BLOCK | jq -r '.tx[] | "\(.txid) \(.vout[].n)"'  )

for i in ${!TX_LIST[@]}; do
    bitcoin-cli gettxout ${TX_LIST[$i]} false | jq -r '.scriptPubKey.address'
done
