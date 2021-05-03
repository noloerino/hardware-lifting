#!/bin/bash

# "(define-fun f2 ((x (_ BitVec 8)) (z (_ BitVec 8))) (_ BitVec 8) (bvadd (_ bv1 8) x))"

# "(define-fun add ((ra (_ BitVec 2)) (rb (_ BitVec 2)) (r1 (_ BitVec 8)) (r2 (_ BitVec 8)) (r3 (_ BitVec 8)) (r4 (_ BitVec 8))) (_ BitVec 8) 
# (ite (and (= (_ bv0 2) ra) (= (_ bv0 2) rb)) (bvadd r1 r1) 
# (ite (and (= (_ bv0 2) ra) (= (_ bv1 2) rb)) (bvadd r1 r2)
# (ite (and (= (_ bv0 2) ra) (= (_ bv2 2) rb)) (bvadd r1 r3)
# (ite (and (= (_ bv0 2) ra) (= (_ bv3 2) rb)) (bvadd r1 r4)
# (ite (and (= (_ bv1 2) ra) (= (_ bv0 2) rb)) (bvadd r2 r1)
# (ite (and (= (_ bv1 2) ra) (= (_ bv1 2) rb)) (bvadd r2 r2)
# (ite (and (= (_ bv1 2) ra) (= (_ bv2 2) rb)) (bvadd r2 r3)
# (ite (and (= (_ bv1 2) ra) (= (_ bv3 2) rb)) (bvadd r2 r4)
# (ite (and (= (_ bv2 2) ra) (= (_ bv0 2) rb)) (bvadd r3 r1)
# (ite (and (= (_ bv2 2) ra) (= (_ bv1 2) rb)) (bvadd r3 r2)
# (ite (and (= (_ bv2 2) ra) (= (_ bv2 2) rb)) (bvadd r3 r3) 
# (ite (and (= (_ bv2 2) ra) (= (_ bv3 2) rb)) (bvadd r3 r4) 
# (ite (and (= (_ bv3 2) ra) (= (_ bv0 2) rb)) (bvadd r4 r1) 
# (ite (and (= (_ bv3 2) ra) (= (_ bv1 2) rb)) (bvadd r4 r2) 
# (ite (and (= (_ bv3 2) ra) (= (_ bv2 2) rb)) (bvadd r4 r3) (bvadd r4 r4) ))))))))))))))))"

FILENAME=supporting/distscript-add.smt
FUNCFILE=supporting/prevfunc.log
LOGFILE=supporting/check.log
MODELFILE=supporting/model.smt

cd distinguisher-with-regs
echo "beginning distinguisher" > $LOGFILE

while :
do

echo "beginning new iteration" >> $LOGFILE

echo "; written by distinguishing oracle" > $FILENAME
echo "(set-logic BV)" >> $FILENAME
echo $1 >> $FILENAME
./gsampler.py add >> $FILENAME

tail -n +2 "$FUNCFILE" > "$FUNCFILE.tmp" && mv "$FUNCFILE.tmp" "$FUNCFILE"

z3 $FILENAME > $MODELFILE

if cat $MODELFILE | grep -q "unsat"
then
    echo "trying next function" >> $LOGFILE
else
	echo "done with iteration" >> $LOGFILE
	./parseop.py add
	break
fi

done

cd ..