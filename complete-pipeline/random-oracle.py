#!/usr/bin/python3.6

import random

regA = random.randint(0,3)
regB = random.randint(0,3)
regInit = random.sample(range(0,256), 4)

# print(regInit)

regOut = (regInit[regA] + regInit[regB]) % 256

# output bitwidths expected
# this should be of length 1
inputwidths = [2, 2, 8, 8, 8, 8]
outputwidths = [8]

allVals = [regA, regB] + regInit + [regOut]
widths = inputwidths + outputwidths




zipped = list(zip(allVals, widths))

print(' '.join(['(_ bv{} {})'.format(i[0], i[1]) for i in zipped]))