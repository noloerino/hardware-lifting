fout = open('riscv.out')

f = fout.readlines()


fs = f[503].split(" ")
hexn = fs[-1]

def twosComplement_hex(hexval):
    val = int(hexval, 16)
    if val >= 2 ** 31:
    	val = val - 2 ** 32
    return val

print(twosComplement_hex("0x" + hexn))