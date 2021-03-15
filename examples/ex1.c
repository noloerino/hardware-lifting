#include "data.h"

// ----------------------------------------------------------------------------------------
// EXAMPLE 1:  This is the sample function from the Spectre paper.
//
// Comments:  The generated assembly (below) includes an LFENCE on the vulnerable code 
// path, as expected

void victim_function_v01(ull x) {
     if (x < array1_size) {
          temp &= array2[array1[x] * 512];
     }
}

//    mov     eax, DWORD PTR array1_size
//    cmp     rcx, rax
//    jae     SHORT $LN2@victim_fun
//    lfence
//    lea     rdx, OFFSET FLAT:__ImageBase
//    movzx   eax, BYTE PTR array1[rdx+rcx]
//    shl     rax, 9
//    movzx   eax, BYTE PTR array2[rax+rdx]
//    and     BYTE PTR temp, al
//  $LN2@victim_fun:
//    ret     0

int main() {
	ull x = 3;
	victim_function_v01(x);
	return 0;
}
