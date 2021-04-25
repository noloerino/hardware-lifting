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


function = sys.argv[1]
function_norm = normalize_str(function)

# mine the function and perform structural checks
astrepr = get_ast(function_norm)
assert len(astrepr) == 1
astrepr = astrepr[0]
assert((astrepr[0] == 'define') and (astrepr[1] == '-') and (astrepr[2] == 'fun'))
assert(len(astrepr) == 7)
assert(len(astrepr[4]) == 2)
funcname = astrepr[3]
funcdef = astrepr[6]
smtop = funcdef[0]
# print(funcdef)



verilogstring = '''
	`ifdef FORMAL
	// (* anyconst *) reg [32:0] past_pc;

	always @(posedge clock) begin
	assume (__lft__tile__alu_io_alu_op == {risc_op});
	assert (__lft__tile__alu_io_A {verilog_op} __lft__tile__alu_io_B == __lft__tile__alu_io_out);
	end
	`endif
'''.format(risc_op=FUNCNAME_TO_RISC_OPCODE[funcname], verilog_op=SMT_TO_SVA_OPERATOR[smtop])

ffhandler = open(FORMALFILE, 'w')
ffhandler.write(verilogstring)
ffhandler.close()





# for d in decls:
# 	print(d)
