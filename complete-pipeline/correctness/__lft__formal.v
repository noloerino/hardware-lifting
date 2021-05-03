
		`ifdef FORMAL
		// (* anyconst *) reg [32:0] past_pc;

		always @(posedge clock) begin
		assume (__lft__tile__alu_io_alu_op == 0);
		assert ((0) == __lft__tile__alu_io_out);
		end
		`endif
	