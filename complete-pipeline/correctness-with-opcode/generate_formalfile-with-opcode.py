#!/usr/bin/python3

import sys
from six.moves import cStringIO
from pysmt.smtlib.parser import SmtLibParser
from lispparser import *

# (define-fun add ((x Bool) (y Bool)) Bool (bvadd x y))

FORMALFILE = '__lft__formal.v'

# not used in the correctness-with-opcode
FUNCNAME_TO_RISC_OPCODE = {
	'func_0000000_000_0110011' : '0',
	'sub' : '1',
	'funcand' : '2',
	'funcor' : '3'
}

SMT_TO_SVA_OPERATOR = {
	'bvadd' : '+',
	'bvsub' : '-',
	'bvlshr' : '>>',
	'bvshl' : '<<',
	'bvor' : '|',
	'bvand' : '&',
	'bvxor' : '^',
	'bvult' : '<'
}

HOOTS_TO_SVA_OPERATOR = {
	'truncate' : '((__op__1__ << __op__2__) >> __op__2__)'
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
		if smt[0] in HOOTS_TO_SVA_OPERATOR:
			return HOOTS_TO_SVA_OPERATOR[smt[0]].replace('__op__1__', get_expr_from_smt(smt[1])).replace(
				'__op__2__', get_expr_from_smt(smt[2]))
		return False
	else:
		if isinstance(smt, int):
			return str(smt)
		if smt in operands:
			return operands[smt]


def main(argv):

	# opcode = argv[0]
	function = argv[0]
	function_norm = normalize_str(function)

	# print(opcode)
	# mine the function and perform structural checks
	astrepr = get_ast(function_norm)

	# print(astrepr)

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

	operands[astrepr[4][0][0]] = 'tgt_rs1'
	operands[astrepr[4][1][0]] = 'tgt_rs2'

	# get function-name
	funcname = astrepr[3]
	# get function definition
	funcdef = astrepr[6]

	instruction_fields = funcname.split('_')

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
		  wire [31:0] fe_inst = __lft__tile__fe_inst;
		  `define SUB_F7 (7'b0100000)
		  `define ADD_F7 (7'b0000000)
		  // Change ADD to SUB and verify that the model check fails
		  wire is_add = fe_inst[31:25] == 7'b{funct1} &&
		    fe_inst[14:12] == 3'b{funct2} &&
		    fe_inst[6:0] == 7'b{opcode} &&
		    fe_inst[11:7] != 5'b0
		    ;

		  reg init = 1;
		  (* anyconst *) reg [31:0] tgt_rs1;
		  (* anyconst *) reg [31:0] tgt_rs2;

		  reg issued = 0;

		  reg [3:0] counter = 0; // Used for debugging
		  always @(posedge clock) begin
		    counter = counter + 1;
		  end

		  // Eventually, if the user specifies a stream of assembly instructions
		  // we will generate a TGT_PC variable for each inst and a corresponding assumption
		  `define TGT_PC (32'h200)
		  always @(posedge clock) begin
		    // Only reset on the first cycle
		    assume(reset == init);
		    init <= 0;

		    if (reset) begin
		      issued <= 0;
		      // These assumptions are needed to ensure that EW_PC isn't initialized to TGT_PC
		      // which screws up issue detection in event of a stall, since EW_PC will continue
		      // to hold its (meaningless) initial value
		      assume(
		        __lft__tile__pc == 0 &&
		        __lft__tile__fe_pc == 0 &&
		        __lft__tile__ew_pc == 0
		      );
		    end
		    // Observe when an instruction enters the pipeline
		    if (!reset && __lft__tile__pc == `TGT_PC) begin
		      issued <= 1;
		    end
		    // Check that a reset didn't occur last cycle
		    // and assume shadow values when an instruction hits this stage
		    if (!reset && !$past(reset) && issued && __lft__tile__fe_pc == `TGT_PC) begin
		      assume(
		        is_add &&
		        tgt_rs1 == __lft__tile__regFile_io_rdata1 &&
		        tgt_rs2 == __lft__tile__regFile_io_rdata2
		      );
		    end
		    // Check that a reset didn't occur in the last 2 cycles
		    // and apply assertions
		    if (!reset && !$past(reset) && !$past(reset, 2) &&
		        issued && __lft__tile__ew_pc == `TGT_PC) begin
		      assert(
		        {verilog_op} == __lft__tile__regFile_io_wdata
		      );
		    end
		    // Uncomment to force a crash to see an example trace
		    // assert(reset || __lft__tile__pc != 32'h204);
		  end
		  `endif

	'''.format(funct1=instruction_fields[1], funct2=instruction_fields[2], opcode=instruction_fields[3],
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