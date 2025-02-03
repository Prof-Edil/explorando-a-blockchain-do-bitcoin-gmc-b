# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`


SCRIPT_WORDS=($(bitcoin-cli decodescript $(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163 true  | jq -rc '.vin[0].txinwitness | last') | jq '.asm'))
echo ${SCRIPT_WORDS[1]}