#include "data.h"

// ----------------------------------------------------------------------------------------
// EXAMPLE 11:  Use memcmp() to read the memory for the leak.
//
// Comments: Output is unsafe.

void victim_function_v11(ull x) {
     if (x < array1_size)
          temp = memcmp(&temp, array2 + (array1[x] * 512), 1);
}

//    mov     eax, DWORD PTR array1_size
//    cmp     rcx, rax
//    jae     SHORT $LN2@victim_fun
//    lea     rax, OFFSET FLAT:array1
//    movzx   ecx, BYTE PTR [rax+rcx]
//    lea     rax, OFFSET FLAT:array2
//    shl     rcx, 9
//    add     rcx, rax
//    movzx   eax, BYTE PTR temp
//    cmp     al, BYTE PTR [rcx]
//    jne     SHORT $LN4@victim_fun
//    xor     eax, eax
//    mov     BYTE PTR temp, al
//    ret     0
//  $LN4@victim_fun:
//    sbb     eax, eax
//    or      eax, 1
//    mov     BYTE PTR temp, al
//  $LN2@victim_fun:
//    ret     0

int main() {
	ull x = 3;
	victim_function_v11(x);
	return 0;
}
