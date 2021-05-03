#!/usr/bin/python3

import sys
from six.moves import cStringIO
from pysmt.smtlib.parser import SmtLibParser
from lispparser import *

# (define-fun add ((x Bool) (y Bool)) Bool (bvadd x y))

FORMALFILE = '__lft__formal.v'

FUNCNAME_TO_RISC_OPCODE = {
	'add' : '0',
	'sub' : '1'
}

SMT_TO_SVA_OPERATOR = {
	'bvadd' : '+',
	'bvsub' : '-'
}

operands = {}

def get_expr_from_smt(smt):
	if isinstance(smt, list):
		if len(smt) != 3:
			return False

		if smt[0] == '_':
			return smt[1][2:]

		if smt[0] in SMT_TO_SVA_OPERATOR:
			return '({}) {} ({})'.format(get_expr_from_smt(smt[1]), 
				SMT_TO_SVA_OPERATOR[smt[0]], get_expr_from_smt(smt[2]))
		return False
	else:
		return operands[smt]


def main(argv):

	function = argv[0]
	function_norm = normalize_str(function)

	# mine the function and perform structural checks
	astrepr = get_ast(function_norm)
	if len(astrepr) != 1:
		print("false")
		return False

	astrepr = astrepr[0]
	if ((astrepr[0] != 'define') or (astrepr[1] != '-') or (astrepr[2] != 'fun')):
		print("false")
		return False

	# check number of tokens from function
	if len(astrepr) != 7:
		print("false")
		return False

	# check operands to the function and catch their order
	if len(astrepr[4]) != 2:
		print("false")
		return False

	operands[astrepr[4][0][0]] = '__lft__tile__alu_io_A'
	operands[astrepr[4][1][0]] = '__lft__tile__alu_io_B'

	# get function-name
	funcname = astrepr[3]
	# get function definition
	funcdef = astrepr[6]

	# print(funcdef)
	# convert funcdef into a verilog expression (to pass into the assert)
	verilogexpr = get_expr_from_smt(funcdef)
	if not verilogexpr:
		print("false")
		return False

	# earlier
	# assert (__lft__tile__alu_io_A {verilog_op} __lft__tile__alu_io_B == __lft__tile__alu_io_out);
	verilogstring = '''
		`ifdef FORMAL
		// (* anyconst *) reg [32:0] past_pc;

		always @(posedge clock) begin
		assume (__lft__tile__alu_io_alu_op == {risc_op});
		assert (({verilog_op}) == __lft__tile__alu_io_out);
		end
		`endif
	'''.format(risc_op=FUNCNAME_TO_RISC_OPCODE[funcname], 
		verilog_op=get_expr_from_smt(funcdef))

	ffhandler = open(FORMALFILE, 'w')
	ffhandler.write(verilogstring)
	ffhandler.close()

	print("true")
	return True


if __name__ == '__main__':
	main(sys.argv[1:])

# for d in decls:
# 	print(d)