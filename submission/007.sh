# Only one single output remains unspent from block 123,321. What addrress was it sent to?

BLOCK_NUMBER=123321



CURRENT_BLOCK=$(bitcoin-cli getblock "$(bitcoin-cli getblockhash $BLOCK_NUMBER )" 2)
mapfile -t TX_LIST < <(  echo $CURRENT_BLOCK | jq -r '.tx[] | "\(.txid) \(.vout[].n)"'  )



while ((${#TX_LIST[@]} > 1 )); do
    NEXT_BH=$(echo $CURRENT_BLOCK | jq -r '.nextblockhash')
    CURRENT_BLOCK=$(bitcoin-cli getblock $NEXT_BH 2)

    mapfile -t NEW_TX_LIST < <(echo $CURRENT_BLOCK | jq -r '.tx[] | "\(.vin[].txid) \(.vin[].vout)"' )
    for i in ${!TX_LIST[@]};do
        for j in ${!NEW_TX_LIST[@]};do
            if [ "${TX_LIST[$i]}" == "${NEW_TX_LIST[$j]}" ]; then
                unset TX_LIST[$i] 
               
            fi 
        done
    done
    unset NEW_TX_LIST
done


UTXO=( $(echo ${TX_LIST[@]}))

 bc getrawtransaction "${UTXO[0]}" true | jq -r ".vout[] | select(.n == ${UTXO[1]})| .scriptPubKey.address"
