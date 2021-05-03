#!/bin/bash

# "(define-fun f2 ((x (_ BitVec 8)) (z (_ BitVec 8))) (_ BitVec 8) (bvadd (_ bv1 8) x))"

FILENAME=supporting/distscript-or.smt
FUNCFILE=supporting/prevfunc.log
LOGFILE=supporting/check.log
MODELFILE=supporting/model.smt

cd distinguisher

while :
do

echo "beginning new iteration" > $LOGFILE

echo "; written by distinguishing oracle" > $FILENAME
echo "(set-logic BV)" >> $FILENAME
echo $1 >> $FILENAME
./gsampler.py funcor >> $FILENAME

tail -n +2 "$FUNCFILE" > "$FUNCFILE.tmp" && mv "$FUNCFILE.tmp" "$FUNCFILE"

z3 $FILENAME > $MODELFILE

if cat $MODELFILE | grep -q "unsat"
then
    echo "trying next function" > $LOGFILE
else
	echo "done with iteration" > $LOGFILE
	./parseop-new.py funcor
	break
fi

done

cd ..