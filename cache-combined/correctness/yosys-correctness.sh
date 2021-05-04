#!/bin/bash
# 
TILEFILE=cache.sv
FORMALFILE=__lft__formal.sv
INSTRFILE=__lft__corr.sv


cd correctness
returnval=$(./generate_formalfile.py "$1")

if [ "$returnval" != "true" ]
then
    echo "false"
else    
    # sed -e '/__lft__INCLUDE_FORMAL_CODE_BLOCK/{r '"$FORMALFILE" -e 'd}' $TILEFILE > $INSTRFILE
    cp $TLEFILE > $INSTRFILE

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
