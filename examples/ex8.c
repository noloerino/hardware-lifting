#include "data.h"

// ----------------------------------------------------------------------------------------
// EXAMPLE 8:  Use a ?: operator to check bounds.

void victim_function_v08(ull x) {
     temp &= array2[array1[x < array1_size ? (x + 1) : 0] * 512];
}

//    cmp     rcx, QWORD PTR array1_size
//    jae     SHORT $LN3@victim_fun
//    inc     rcx
//    jmp     SHORT $LN4@victim_fun
//  $LN3@victim_fun:
//    xor     ecx, ecx
//  $LN4@victim_fun:
//    lea     rdx, OFFSET FLAT:__ImageBase
//    movzx   eax, BYTE PTR array1[rcx+rdx]
//    shl     rax, 9
//    movzx   eax, BYTE PTR array2[rax+rdx]
//    and     BYTE PTR temp, al
//    ret     0

int main() {
	ull x = 3;
	victim_function_v08(x);
	return 0;
}
