#!/bin/bash

TILEFILE=Tile_aluop_withreset.v
FORMALFILE=__lft__formal.v
INSTRFILE=__lft__corr.v


cd correctness-with-opcode
returnval=$(./generate_formalfile-with-opcode.py "$1")

# {echo "Generated FORMAL block for refinement checking"}
# echo $returnval

if [ "$returnval" != "true" ]
then
	echo "false"
else	
	# echo "FORMAL block clean; performing refinement check with SymbiYosys"
	sed -e '/__lft__INCLUDE_FORMAL_CODE_BLOCK/{r '"$FORMALFILE" -e 'd}' $TILEFILE > $INSTRFILE

	result=$(sby -f corr.sby taskBMC | tail -n 2)

	if echo "$result" | grep -q "PASS"
	then
			echo "true"
	else
			echo "false"
	fi
	# rm -f $INSTRFILE
fi
# rm -f $FORMALFILE
cd ..
