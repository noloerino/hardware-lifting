// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2017 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0

// See also the EXAMPLE section in the verilator manpage/document.
module top
	(input clk,
	// input wren,
	// input rden,
	input [3:0] addr,
	input reg [7:0] inp,
	output reg [7:0] oup);

	reg [7:0] regfile [15:0];

	initial begin
//		$display("Hello World!");
//		$finish;
   	end

	always @(posedge clk) begin 
		// if (wren) 
		regfile[addr] <= inp;
		// if (rden) 
		oup <= regfile[addr];
	end
endmodule
