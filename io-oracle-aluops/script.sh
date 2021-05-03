#!/bin/bash

regA=$1
regB=$2
regD=$3

valA=$4
valB=$5

op=$6

targetInst=`python3 gen.py $regA $regB $regD $valA $valB $op tmp.hex`

./VTile tmp.hex 2> output.vcd > /dev/null

res=`python3 read.py output.vcd $targetInst`

echo $res