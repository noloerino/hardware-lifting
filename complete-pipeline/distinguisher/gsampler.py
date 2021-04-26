#!/usr/bin/python3.6

import sys
import random
from collections import OrderedDict
from itertools import product

PREVFUNCFILE="./supporting/prevfunc.log"

import configfile

grammar_list = configfile.grammar_list

index_list = {grammar_list[ind][0] : ind for ind in range(len(grammar_list))}

grammar = OrderedDict(grammar_list)

def flatten(x):
    if isinstance(x, collections.Iterable):
        return [a for i in x for a in flatten(i)]
    else:
        return [x]

def generate_all():	
    lengths = [len(grammar[key]) for key in grammar]
    opts = product(*[range(i) for i in lengths])
    return [' '.join(str(i) for i in opt) for opt in opts]

def guided_sample(guide):
    curr = ["NT_start"]
    # iteration = 0

    def make_pass(curr_list):
        newlist = []
        allclean = True
        for item in curr_list:
            if item.startswith("NT_"):
                replacement = grammar[item][guide[index_list[item]]]
                newlist.extend(replacement)
                allclean = False
            else:
                newlist.append(item)

        return allclean, newlist

    while True:
        stop, curr = make_pass(curr)
        if stop:
            break
    return(' '.join(curr))


def random_sample(bound = 10):
	curr = ["NT_start"]
	iteration = 0

	def make_pass(curr_list):
		newlist = []
		allclean = True
		for item in curr_list:
			if item.startswith("NT_"):
				replacement = random.choice(grammar[item])
				newlist.extend(replacement)
				allclean = False
			else:
				newlist.append(item)

		return allclean, newlist

	while iteration < bound:
		stop, curr = make_pass(curr)
		if stop:
			break
		iteration += 1
	return(' '.join(curr))

def harness(funcdef):
    inputwidths = configfile.inputwidths
    outputwidths = configfile.outputwidths

    opstr = "(define-fun %s " % "f1"

    tagged_inputs = zip(range(1, len(inputwidths)+1), inputwidths)
    declarestmts = '(' + ' '.join(['(a{} (_ BitVec {}))'.format(ip[0], ip[1]) for ip \
        in tagged_inputs]) + ')'
    outputstmts = ' (_ BitVec {}) '.format(outputwidths[0])

    opstr += declarestmts + ' ' + outputstmts
    opstr += funcdef
    opstr += " )"
    return opstr


def generate_smt_statements(function_to_check):
    inputwidths = configfile.inputwidths
    outputwidths = configfile.outputwidths

    tagged_inputs = zip(range(1, len(inputwidths)+1), inputwidths)
    declarestmts = '\n'.join(['(declare-const i{} (_ BitVec {}))'.format(ip[0], ip[1]) for \
    ip in tagged_inputs])

    ilist = ['i{}'.format(v) for v in range(1, len(inputwidths)+1)]

    assertionstmts = '''
(assert
    (not (= 
        (f1 {})
        ({} {})
        ))
    )
'''.format(' '.join(ilist), function_to_check, ' '.join(ilist))

    smtstmts = declarestmts + '\n' + assertionstmts
    smtstmts += '\n(check-sat)\n(get-model)'
    return smtstmts


def main(argv):
    logfile_name = PREVFUNCFILE
    logfile_handler = open(logfile_name, 'r+')

    prevfun_data = logfile_handler.readlines()
    # logfile_handler.truncate(0)

    if len(prevfun_data) == 0:
        all_funcs = generate_all()
        all_funcs = [func + '\n' for func in all_funcs]
        prevfun_data = all_funcs
        logfile_handler.writelines(all_funcs)

    function = guided_sample(list(map(int, prevfun_data[0].split())))
    print(harness(function))
    print(generate_smt_statements(argv[0]))

if __name__ == '__main__':
	main(sys.argv[1:])
