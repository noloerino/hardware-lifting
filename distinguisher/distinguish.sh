#!/bin/bash

# "(define-fun f2 ((x (_ BitVec 8)) (z (_ BitVec 8))) (_ BitVec 8) (bvadd (_ bv1 8) x))"

FILENAME=distscript.smt
FUNCFILE=prevfunc.log

while [ -s $FUNCFILE ]
do

echo "beginning new iteration" > check.log

echo "; written by distinguishing oracle" > $FILENAME
echo "(set-logic BV)" >> $FILENAME
echo $1 >> $FILENAME
./gsampler.py f1 >> $FILENAME

tail -n +2 "$FUNCFILE" > "$FUNCFILE.tmp" && mv "$FUNCFILE.tmp" "$FUNCFILE"

z3 $FILENAME > model.smt

if cat model.smt | grep -q "unsat"
then
    echo "trying next function" > check.log
else
	echo "done with iteration" > check.log
	./parseop.py
	break
fi

done