#include "data.h"

// ----------------------------------------------------------------------------------------
// EXAMPLE 10:  Leak a comparison result.
//
// Comments: Output is unsafe.  Note that this vulnerability is a little different, namely
// the attacker is assumed to provide both x and k.  The victim code checks whether 
// array1[x] == k.  If so, the victim reads from array2[0].  The attacker can try
// values for k until finding the one that causes array2[0] to get brought into the cache.

void victim_function_v10(ull x, ull k) {
     if (x < array1_size) {
          if (array1[x] == k)
               temp &= array2[0];
     }
}

//    mov     eax, DWORD PTR array1_size
//    cmp     rcx, rax
//    jae     SHORT $LN3@victim_fun
//    lea     rax, OFFSET FLAT:array1
//    cmp     BYTE PTR [rcx+rax], dl
//    jne     SHORT $LN3@victim_fun
//    movzx   eax, BYTE PTR array2
//    and     BYTE PTR temp, al
//  $LN3@victim_fun:
//    ret     0

int main() {
	ull x = 3, k = 3;
	victim_function_v10(x, k);
	return 0;
}
