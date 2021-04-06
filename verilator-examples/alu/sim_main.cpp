// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2017 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0
//======================================================================

#include <iostream>
#include <sstream>
// std::unique_ptr
#include <memory>
#include <string>
// Include common routines
#include <verilated.h>

#include "portconfig.h"

// Include model header, generated from Verilating .v file
#ifdef LIFTED
#include "VALUSimple_Lifted.h"
#else
#include "VALUSimple.h"
#endif


// std::string get_bved(int value, int width=32){
//  return std::format("(_ bv{} {})", value, width);
// }

int main(int argc, char** argv, char** env) {
    // See a similar example walkthrough in the verilator manpage.

    // This is intended to be a minimal example.  Before copying this to start a
    // real project, it is better to start with a more complete example,
    // e.g. examples/c_tracing.

    // Prevent unused variable warnings
    if (false && argc && argv && env) {}

    // logs directory
    Verilated::mkdir("logs");

    // Construct the Verilated model, from Vtop.h generated from Verilating "top.v"
    #ifdef LIFTED
    VALUSimple_Lifted* top = new VALUSimple_Lifted;
    #else
    VALUSimple* top = new VALUSimple;
    #endif

    top->clk = 0;
    top->reset = 0;
    top->io_A = 0;
    top->io_B = 0;
    top->io_alu_op = 0;
    int cycle_count = CYCLE_CNT;
    // int addr_inps[cycle_count];
    // int inp_inps[cycle_count];
    // for (int i = 0; i < cycle_count; ++i)
    // {
    //  std::cin >> addr_inps[i];
    //  std::cin >> inp_inps[i];
    // }
    // std::istringstream ss(argv[1]);
    // int clinp;
    int curr_cycle = 0;

    // Simulate until $finish
    while (!Verilated::gotFinish() && curr_cycle <= cycle_count + 1) {
        
        top->clk = !top->clk;
        top->eval();        
        
        // Evaluate model
        if (top->clk) {
#ifdef SMO
            // NODEBUG: SMO requested output
            if (curr_cycle == cycle_count + 1) {
                ADD_SMO_PRINTING_STMTS
                VL_PRINTF("\n");
            }
#else
            ADD_DEBUG_PRINTING_STMTS
#endif
        }
        // Set inputs
        else if (curr_cycle < cycle_count) {
            int offset = 1;
            ADD_SET_INPUTS
        }

        if (!top->clk) curr_cycle++;
    }

    // Final model cleanup
    top->final();

    // Destroy model
    delete top;

    // Return good completion status
    return 0;
}
