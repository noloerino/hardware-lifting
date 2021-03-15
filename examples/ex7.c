#include "data.h"

// ----------------------------------------------------------------------------------------
// EXAMPLE 7:  Compare against the last known-good value.
//
// Comments: Output is unsafe.

void victim_function_v07(ull x) {
     static ull last_x = 0;
     if (x == last_x)
          temp &= array2[array1[x] * 512];
     if (x < array1_size)
          last_x = x;
}

//    mov     rdx, QWORD PTR ?last_x@?1??victim_function_v07@@9@9
//    cmp     rcx, rdx
//    jne     SHORT $LN2@victim_fun
//    lea     r8, OFFSET FLAT:__ImageBase
//    movzx   eax, BYTE PTR array1[r8+rcx]
//    shl     rax, 9
//    movzx   eax, BYTE PTR array2[rax+r8]
//    and     BYTE PTR temp, al
//  $LN2@victim_fun:
//    mov     eax, DWORD PTR array1_size
//    cmp     rcx, rax
//    cmovb   rdx, rcx
//    mov     QWORD PTR ?last_x@?1??victim_function_v07@@9@9, rdx
//    ret     0

int main() {
	ull x = 3;
	victim_function_v07(x);
	return 0;
}
