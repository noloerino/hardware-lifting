// Constrained under the assumption that io_alu_op is always equal to either COPY_A  or COPY_B
// (10 or 11, respectively, but trimmed to 0/1).
module top(
  input         clk,
  input         reset,
  input  [31:0] io_A,
  input  [31:0] io_B,
  input         io_alu_op,
  output [31:0] io_out
);
  wire is_copy_a = io_alu_op == 1'd0;
  assign io_out = is_copy_a ? io_A : io_B;
endmodule
