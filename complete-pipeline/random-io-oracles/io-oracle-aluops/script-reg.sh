#!/bin/bash

CURRDIR=./random-io-oracles/io-oracle-aluops
regA=$1
regB=$2
regD=$3

valA=$4
valB=$5

op=$6

# DUMPFILE=__lft__dump_frag.vcd

# echo "python3 $CURRDIR/gen-reg.py $regA $regB $regD $valA $valB $op $CURRDIR/tmp.hex"
targetInst=`python3 $CURRDIR/gen-reg.py $regA $regB $regD $valA $valB $op $CURRDIR/tmp.hex`
# echo $targetInst
$CURRDIR/VTile $CURRDIR/tmp.hex 2> $CURRDIR/output.vcd > /dev/null
mv $(pwd)/dump.vcd $CURRDIR

# grep -C 100 "$targetInst" $CURRDIR/dump.vcd 

res=`python3 $CURRDIR/read-reg.py $CURRDIR/output.vcd $targetInst`
destreg=`python3 $CURRDIR/read-reg-dest.py $CURRDIR/output.vcd $targetInst`
# echo $res
breg=`grep -C 20 "$res" $CURRDIR/dump.vcd | grep 'b$'`
creg=`grep -C 20 "$res" $CURRDIR/dump.vcd | grep 'c$'`
echo $breg $creg $destreg