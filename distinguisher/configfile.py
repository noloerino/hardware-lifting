# name of the I/O oracle binary that is supposed to be called
oraclename = "./Vtop"
synthfunname = "storeVal"

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
