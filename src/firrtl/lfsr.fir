circuit LFSR:
    ; Implements a 16-bit Fibonacci LFSR
    ; https://en.wikipedia.org/wiki/Linear-feedback_shift_register
    module LFSR:
        input clock : Clock
        input reset : UInt<1>
        reg state : UInt<16>, clock with :
            reset => (reset, UInt<16>("h0"))
        node b10 = bits(state, 10, 10)
        node b12 = bits(state, 12, 12)
        node b13 = bits(state, 13, 13)
        node b15 = bits(state, 15, 15)
        node new_msb = xor(b10, xor(b12, xor(b13, b15)))
        state <= or(new_msb, bits(state, 14, 1))
