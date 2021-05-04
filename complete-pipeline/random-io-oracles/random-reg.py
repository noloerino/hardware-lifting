#!/usr/bin/python3.6

import sys
import random
import subprocess
import os
from lispparser import *


def main(argv):

	function = argv[0]
	function_norm = normalize_str(function)
	astrepr = get_ast(function_norm)[0]
	funcname = astrepr[3]
	
	regA = random.randint(10,15)
	# regA = 0
	regB = random.randint(10,15)
	regDest = random.randint(11,15)
	# regB = 1
	regInit = random.sample(range(0,256), 2)

	oraclename= "./random-io-oracles/io-oracle-aluops/script-reg.sh"
	args = [oraclename]
	inputs = [str(regA), str(regB), str(regDest), regInit[0], regInit[1], 'add']
	args += list(map(str, inputs))
	# print(args)
	popen = subprocess.Popen(args, stdout=subprocess.PIPE)
	popen.wait()

	# print(a)

	regOut = str(popen.stdout.read(), 'UTF-8').strip()
	# print(regOut)
	# regOut = (regInit[regA] + regInit[regB]) % 256


	# output bitwidths expected
	# this should be of length 1
	inputwidths = [5, 5, 5]
	outputwidths = [5]
	
	if 'src1' in funcname:
		regOut = int(regOut[1:6], 2)
	elif 'src2' in funcname:
		regOut = int(regOut[10:15], 2)
	elif 'dest' in funcname:
		regOut = int(regOut[18:])
	allVals = [regA, regB, regDest, regOut]
	widths = inputwidths + outputwidths

	zipped = list(zip(allVals, widths))

	print(' '.join(['(_ bv{} {})'.format(i[0], i[1]) for i in zipped]))

if __name__ == '__main__':
	main(sys.argv[1:])