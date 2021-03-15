#include "data.h"

// ----------------------------------------------------------------------------------------
// EXAMPLE 5:  Use x as the initial value in a for() loop.
//
// Comments: Output is unsafe.

void victim_function_v05(ull x) {
     ull i;
     if (x < array1_size) {
          for (i = x - 1; i > 0; i--)
               temp &= array2[array1[i] * 512];
     }
}

//    mov     eax, DWORD PTR array1_size
//    cmp     rcx, rax
//    jae     SHORT $LN3@victim_fun
//    movzx   edx, BYTE PTR temp
//    lea     r8, OFFSET FLAT:__ImageBase
//    lea     rax, QWORD PTR array1[r8-1]
//    add     rax, rcx
//  $LL4@victim_fun:
//    movzx   ecx, BYTE PTR [rax]
//    lea     rax, QWORD PTR [rax-1]
//    shl     rcx, 9
//    and     dl, BYTE PTR array2[rcx+r8]
//    jmp     SHORT $LL4@victim_fun
//  $LN3@victim_fun:
//    ret     0

int main() {
	ull x = 3;
	victim_function_v05(x);
	return 0;
}
