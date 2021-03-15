#include "data.h"

// ----------------------------------------------------------------------------------------
// EXAMPLE 15:  Pass a pointer to the length
//
// Comments: Output is unsafe.

void victim_function_v15(ull *x) {
     if (*x < array1_size)
          temp &= array2[array1[*x] * 512];
}

//    mov     rax, QWORD PTR [rcx]
//    cmp     rax, QWORD PTR array1_size
//    jae     SHORT $LN2@victim_fun
//    lea     rcx, OFFSET FLAT:__ImageBase
//    movzx   eax, BYTE PTR array1[rax+rcx]
//    shl     rax, 9
//    movzx   eax, BYTE PTR array2[rax+rcx]
//    and     BYTE PTR temp, al
//  $LN2@victim_fun:
//    ret     0

int main() {
	ull x = 3;
	victim_function_v15(&x);
	return 0;
}
