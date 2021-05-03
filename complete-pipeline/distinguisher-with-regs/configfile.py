modelfile = "supporting/model.smt"

# name of the I/O oracle binary that is supposed to be called
oraclename = {
	"add" : "./oracles/add-io",
	"sub" : "./oracles/sub-io"
	}
# can have many functions with different names
# synthfunname = "add"

grammar_list = [("NT_start", [["NT_BV1"]]), \
	("NT_BV1", [["(", "NT_BVOP", "NT_BV2", "NT_BV2", ")"], \
				["(", "ite", "NT_BOOL1", "NT_BV2", "NT_BV2", ")"], \
				["NT_BV2"]]), \
	("NT_BV2", [["(", "NT_BVOP", "NT_BV3", "NT_BV3", ")"], \
				["(", "ite", "NT_BOOL1", "NT_BV3", "NT_BV3", ")"], \
				["NT_BV3"]]), \
	("NT_BV3", [["(", "NT_BVOP", "NT_BV4", "NT_BV4", ")"], \
				["(", "ite", "NT_BOOL1", "NT_BV4", "NT_BV4", ")"], \
				["NT_BV4"]]), \
	("NT_BV4", [["a3"], ["a4"], ["a5"], ["a6"],  ["(_ bv0 8)"]]), \
	("NT_BVOP", [["bvadd"], ["bvsub"]]), \
	("NT_BOOL1", [["(", "and", "NT_BOOL2", "NT_BOOL2", ")"]]), \
	("NT_BOOL2", [["(", "=", "NT_RA", "NT_RAC", ")"]]), \
	("NT_RA", [["a1"], ["a2"]]), \
	("NT_RAC", [["(_ bv0 2)"], ["(_ bv1 2)"], ["(_ bv2 2)"], ["(_ bv3 2)"]])]

# inputwidths
inputwidths = [2, 2, 8, 8, 8, 8]
# output bitwidths expected
# this should be of length 1
outputwidths = [8]
assert len(outputwidths) == 1
