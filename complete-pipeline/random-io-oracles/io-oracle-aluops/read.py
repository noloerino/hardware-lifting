import sys

targetInst = sys.argv[2]
mainStarted = False
finalRegVal = ""

with open(sys.argv[1]) as f:
    lines = f.readlines()
    for line in lines:
        if line[:10] == "Simulation":
            break
        # print(line)
        assert line[:4] == "PC: ", "Malformed output"
        assert line[13:21] == ", INST: ", "Malformed output"
        assert line[29:35] == ", REG[", "Malformed output"
        assert line[37:42] == "] <- ", "Malformed output"
        pc = line[4:13]
        regValue = line[42:50]
        inst = line[21:29]
        if pc == "00000049c":
            mainStarted = True
        if mainStarted:
            if inst == targetInst:
                finalRegVal = regValue

print(finalRegVal)

