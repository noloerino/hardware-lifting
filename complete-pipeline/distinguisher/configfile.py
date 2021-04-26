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
				["NT_BV2"]]), \
	("NT_BV2", [["a1"], ["a2"], ["(_ bv0 8)"]]), \
	("NT_BVOP", [["bvadd"], ["bvsub"]])] \

# inputwidths
inputwidths = [8, 8]
# output bitwidths expected
# this should be of length 1
outputwidths = [8]
assert len(outputwidths) == 1
