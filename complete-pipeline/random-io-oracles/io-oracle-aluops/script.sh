#!/bin/bash

CURRDIR=$(pwd)/random-io-oracles/io-oracle-aluops
regA=$1
regB=$2
regD=$3

valA=$4
valB=$5

op=$6

targetInst=`python3 $CURRDIR/gen.py $regA $regB $regD $valA $valB $op $CURRDIR/tmp.hex`

$CURRDIR/VTile $CURRDIR/tmp.hex 2> $CURRDIR/output.vcd > /dev/null

res=`python3 $CURRDIR/read.py $CURRDIR/output.vcd $targetInst`

echo $res