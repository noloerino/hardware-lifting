circuit Regfile:
    module Regfile :
        input clock : Clock
        input read : UInt<1>
        input write : UInt<1>
        input ivalue : UInt<32>
        output ovalue : UInt<32>
        input reg_sel : UInt<2>
        reg data: UInt<32> [4], clock
        when read :
            ovalue <= data[reg_sel]
        else :
            ovalue is invalid
        when write :
            data[reg_sel] <= ivalue
