// DESCRIPTION: Verilator: C++ frontend input-redirection template
//
// 29 March 2021 : Adwait
//======================================================================
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2017 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0
//======================================================================

// input-output for interacting as SMO Oracle
#include <iostream>
// safe pointer (not really needed)
#include <memory>

// setup the input and output ports 
#include "portconfig.h"

// Include common routines
#include <verilated.h>
// Include model header, generated from Verilating "top.v"
// FILE MUST BE "top.v"
#include "Vtop.h"


// INPUT FORMAT
/*
	first line
		n: number of cycles
	for each of the next n lines: 
	(where inputs are in the order specified in "portconfig.h")
		i1 i2 .. ik: inputs at each cycle
*/

int main(int argc, char** argv, char** env) {

    // Prevent unused variable warnings
    if (false && argc && argv && env) {}

	// Setup logs directory
	Verilated::mkdir("logs");

    // Construct the Verilated model, from Vtop.h generated from Verilating "top.v"
    Vtop* top = new Vtop;

    // Initialize the clock
	top->clk = 0;

	// Initialize and read cycle count
	int cycle_count;
	std::cin >> cycle_count;
	// This is input variable for each cycle
	int input;

    // Simulate until $finish or cycle_count is reached
    while (!Verilated::gotFinish() && cycle_count) {
		
		top->clk = !top->clk;

		// Set input signals on negative clock edges
		// So that they can be sampled at the positive edge
		if (!top->clk) {
			cycle_count--;
			
			// Set inputs (see portconfig.h for order)
			ADD_SET_INPUTS
			
			// Evaluate model
			top->eval();

#ifdef SMO
			// NODEBUG: SMO requested output
			ADD_SMO_PRINTING_STMTS
#else
			// Print debugging stuff
			VL_PRINTF("[clk=%x]", top->clk); 
			ADD_DEBUG_PRINTING_STMTS
			VL_PRINTF("\n");
#endif

		}
    }

    // Final model cleanup
    top->final();

    // Destroy model
    delete top;

    // Return good completion status
    return 0;
}
