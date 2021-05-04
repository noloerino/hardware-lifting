
	`ifdef FORMAL
	// (* anyconst *) reg [32:0] past_pc;

	always @(posedge clock) begin
	assume (__lft__tile__alu_io_alu_op == 0);
	assert (__lft__tile__alu_io_A - __lft__tile__alu_io_B == __lft__tile__alu_io_out);
	end
	`endif
