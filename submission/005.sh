# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

mapfile -t PK < <(bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517 true | jq -r '.vin[].txinwitness[1]')

bitcoin-cli -named createmultisig nrequired=1 keys='''["'${PK[0]}'","'${PK[1]}'","'${PK[2]}'","'${PK[3]}'"]''' | jq -r '.address'
