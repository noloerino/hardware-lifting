#!/bin/bash

TILEFILE=Tile_aluop.v
FORMALFILE=__lft__formal.v
INSTRFILE=__lft__corr.v

./generate_formalfile.py "$1"

sed -e '/__lft__INCLUDE_FORMAL_CODE_BLOCK/{r '"$FORMALFILE" -e 'd}' $TILEFILE > $INSTRFILE

result=$(sby -f corr.sby taskBMC | tail -n 2)

if echo "$result" | grep -q "PASS"
then
		echo "true"
else
		echo "false"
fi

rm -f $FORMALFILE
rm -f $INSTRFILE
