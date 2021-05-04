
		      `ifdef FORMAL
		      wire [31:0] fe_inst = __lft__tile__fe_inst;
		      wire [31:0] ew_inst = __lft__tile__ew_inst;
		      `define SUB_F7 (7'b0100000)
		      `define ADD_F7 (7'b0000000)
		      // Change ADD to SUB and verify that the model check fails
		      wire is_add = 
		        // fe_inst[31:25] == 7'b0000000 &&
		        // fe_inst[14:12] == 3'b000 &&
		        fe_inst[6:0] == 7'b0110011 &&
		        fe_inst[11:7] != 5'b0
		        ;

		      reg init = 1;
		      (* anyconst *) reg [31:0] tgt_rs1;
		      (* anyconst *) reg [31:0] tgt_rs2;

		      reg issued = 0;

		      reg [3:0] counter = 0; // Used for debugging
		      always @(posedge clock) begin
		        counter = counter + 1;
		      end

		      // Eventually, if the user specifies a stream of assembly instructions
		      // we will generate a TGT_PC variable for each inst and a corresponding assumption
		      `define TGT_PC (32'h200)
		      always @(posedge clock) begin
		        // Only reset on the first cycle
		        assume(reset == init);
		        init <= 0;

		        if (reset) begin
		          issued <= 0;
		          // These assumptions are needed to ensure that EW_PC isn't initialized to TGT_PC
		          // which screws up issue detection in event of a stall, since EW_PC will continue
		          // to hold its (meaningless) initial value
		          assume(
		            __lft__tile__pc == 0 &&
		            __lft__tile__fe_pc == 0 &&
		            __lft__tile__ew_pc == 0
		          );
		        end
		        // Observe when an instruction enters the pipeline
		        if (!reset && __lft__tile__pc == `TGT_PC) begin
		          issued <= 1;
		        end
		        // Check that a reset didn't occur last cycle
		        // and assume shadow values when an instruction hits this stage
		        if (!reset && !$past(reset) && issued && __lft__tile__fe_pc == `TGT_PC) begin
		          assume(
		            is_add 
		            // &&
		            // tgt_rs1 == __lft__tile__regFile_io_rdata1 &&
		            // tgt_rs2 == __lft__tile__regFile_io_rdata2
		          );
		        end
		        // Check that a reset didn't occur in the last 2 cycles
		        // and apply assertions
		        if (!reset && !$past(reset) && !$past(reset, 2) &&
		            issued && __lft__tile__ew_pc == `TGT_PC) begin
		          assert(
		            ew_inst[11:7] == __lft__tile__regFile_io_waddr
		            // (tgt_rs1) - (tgt_rs2) == __lft__tile__regFile_io_wdata
		          );
		        end
		        // Uncomment to force a crash to see an example trace
		        // assert(reset || __lft__tile__pc != 32'h204);
		      end
		      `endif

		