#!/usr/bin/python3.6

import sys
import collections
from pysmt.smtlib.parser import SmtLibParser
from six.moves import cStringIO # Py2-Py3 Compatibility
from z3 import *
import subprocess

import configfile

dist_input = {}
dist_values = {}

modelfile = open('model.smt', 'r')

def get_outputs(inps):
	# run the oracle and get the inputs
	args = [configfile.oraclename]
	args += list(map(str, inps))
	# print(args)
	popen = subprocess.Popen(args, stdout=subprocess.PIPE)
	popen.wait()
	output = popen.stdout.read()
	return str(output, 'UTF-8')

if 'unsat' in modelfile.readline():
	oracle_inwidths = configfile.inputwidths
	oracle_outwidths = configfile.outputwidths
	outstring = ['true'] + ['(_ bv0 {})'.format(width) for width in oracle_inwidths + oracle_outwidths]
	print(' '.join(outstring))
else:
	readmodel = modelfile.read().split('\n')
	assert 'model' in readmodel[0]
	smtlibmodel = '\n'.join(readmodel[1:-2])
	parser = SmtLibParser()
	script = parser.get_script(cStringIO(smtlibmodel))
	defns = script.filter_by_command_name('define-fun')
	for defn in defns:
		if defn[1][0].startswith('i'):
			dist_input[defn[1][0]] = '(_ bv{} {})'.format(defn[1][3].constant_value(), defn[1][3].bv_width())
			dist_values[defn[1][0]] = defn[1][3].constant_value()

	dist_input = collections.OrderedDict(sorted(dist_input.items()))
	dist_values = collections.OrderedDict(sorted(dist_values.items()))
	input_array = [str(dist_values[key]) for key in dist_values]
	print('false ' + ' '.join([dist_input[key] for key in dist_input] + [get_outputs(input_array)]))