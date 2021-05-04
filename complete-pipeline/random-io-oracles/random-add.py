#!/usr/bin/python3.6

import sys
import random
import subprocess
import os

# regA = random.randint(0,3)
regA = 0
# regB = random.randint(0,3)
regB = 1
regInit = random.sample(range(0,256), 2)

oraclename= "./random-io-oracles/io-oracle-aluops/script.sh"
args = [oraclename]
inputs = ['1', '2', '3', regInit[regA], regInit[regB], 'add']
args += list(map(str, inputs))
# print(args)
popen = subprocess.Popen(args, stdout=subprocess.PIPE)
popen.wait()

regOut = str(popen.stdout.read(), 'UTF-8').strip()
# regOut = (regInit[regA] + regInit[regB]) % 256


# output bitwidths expected
# this should be of length 1
inputwidths = [8, 8]
outputwidths = [8]
regOut = int(regOut[-2:], 16)
allVals = regInit + [regOut]
widths = inputwidths + outputwidths

zipped = list(zip(allVals, widths))

print(' '.join(['(_ bv{} {})'.format(i[0], i[1]) for i in zipped]))

if __name__ == '__main__':
	main(sys.argv[1:])