#include "data.h"

// ----------------------------------------------------------------------------------------
// NESTED IF EX3: When the .
//
// Comments: Output is unsafe.

void victim_function_nested_ex3(ull x) {
     ull val1, val2;
     if (x < array1_size) {
     	val1 = array1[x];
     	if (val1 & 1) {
     		val2 = array2[0];
     	}
     }
}

int main() {
	ull x = 3;
	victim_function_nested_ex3(x);
	return 0;
}
