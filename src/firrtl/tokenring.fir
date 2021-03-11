circuit TokenRing :
    module TokenRing :
        input clock : Clock
        input reset : UInt<1>
        ; ivalue is only read on reset
        input ivalue : UInt<32>
        output ovalue : UInt<32>
        reg r1 : UInt<32>, clock with :
            reset => (reset, ivalue)
        ; https://github.com/chipsalliance/firrtl/issues/1479
        reg rs: UInt<32> [15], clock with :
            reset => (reset, zeroes)
        ovalue <= r1
        wire zeroes: UInt<32> [15]
        zeroes[0] <= UInt(0)
        zeroes[1] <= UInt(0)
        zeroes[2] <= UInt(0)
        zeroes[3] <= UInt(0)
        zeroes[4] <= UInt(0)
        zeroes[5] <= UInt(0)
        zeroes[6] <= UInt(0)
        zeroes[7] <= UInt(0)
        zeroes[8] <= UInt(0)
        zeroes[9] <= UInt(0)
        zeroes[10] <= UInt(0)
        zeroes[11] <= UInt(0)
        zeroes[12] <= UInt(0)
        zeroes[13] <= UInt(0)
        zeroes[14] <= UInt(0)
        r1 <= rs[14]
        rs[0] <= r1
        rs[1] <= rs[0]
        rs[2] <= rs[1]
        rs[3] <= rs[2]
        rs[4] <= rs[3]
        rs[5] <= rs[4]
        rs[6] <= rs[5]
        rs[7] <= rs[6]
        rs[8] <= rs[7]
        rs[9] <= rs[8]
        rs[10] <= rs[9]
        rs[11] <= rs[10]
        rs[12] <= rs[11]
        rs[13] <= rs[12]
        rs[14] <= rs[13]
