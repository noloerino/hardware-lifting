circuit Regfile:
    module Regfile :
        input clock : Clock
        input read : UInt<1>
        input write : UInt<1>
        input ivalue : UInt<32>
        output ovalue : UInt<32>
        input reg_sel : UInt<2>
        reg data: UInt<32> [4], clock with :
            reset => (UInt<1>("h0"), UInt<32>("h0"))
        when read :
            ovalue <= data[reg_sel]
        when write :
            data[reg_sel] <= ivalue
