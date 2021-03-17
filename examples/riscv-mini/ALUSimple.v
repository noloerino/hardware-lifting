module ALUSimple(
  input         clock,
  input         reset,
  input  [31:0] io_A,
  input  [31:0] io_B,
  input  [3:0]  io_alu_op,
  output [31:0] io_out,
  output [31:0] io_sum
);
  wire [4:0] shamt = io_B[4:0]; // @[ALU.scala 45:19]
  wire [31:0] _T_1 = io_A + io_B; // @[ALU.scala 48:25]
  wire [31:0] _T_3 = io_A - io_B; // @[ALU.scala 49:25]
  wire [31:0] _T_6 = $signed(io_A) >>> shamt; // @[ALU.scala 50:42]
  wire [31:0] _T_7 = io_A >> shamt; // @[ALU.scala 51:25]
  wire [62:0] _GEN_0 = {{31'd0}, io_A}; // @[ALU.scala 52:25]
  wire [62:0] _T_8 = _GEN_0 << shamt; // @[ALU.scala 52:25]
  wire  _T_11 = $signed(io_A) < $signed(io_B); // @[ALU.scala 53:32]
  wire  _T_12 = io_A < io_B; // @[ALU.scala 54:25]
  wire [31:0] _T_13 = io_A & io_B; // @[ALU.scala 55:25]
  wire [31:0] _T_14 = io_A | io_B; // @[ALU.scala 56:25]
  wire [31:0] _T_15 = io_A ^ io_B; // @[ALU.scala 57:25]
  wire  _T_16 = 4'h0 == io_alu_op; // @[Mux.scala 80:60]
  wire [31:0] _T_17 = _T_16 ? _T_1 : io_B; // @[Mux.scala 80:57]
  wire  _T_18 = 4'h1 == io_alu_op; // @[Mux.scala 80:60]
  wire [31:0] _T_19 = _T_18 ? _T_3 : _T_17; // @[Mux.scala 80:57]
  wire  _T_20 = 4'h9 == io_alu_op; // @[Mux.scala 80:60]
  wire [31:0] _T_21 = _T_20 ? _T_6 : _T_19; // @[Mux.scala 80:57]
  wire  _T_22 = 4'h8 == io_alu_op; // @[Mux.scala 80:60]
  wire [31:0] _T_23 = _T_22 ? _T_7 : _T_21; // @[Mux.scala 80:57]
  wire  _T_24 = 4'h6 == io_alu_op; // @[Mux.scala 80:60]
  wire [62:0] _T_25 = _T_24 ? _T_8 : {{31'd0}, _T_23}; // @[Mux.scala 80:57]
  wire  _T_26 = 4'h5 == io_alu_op; // @[Mux.scala 80:60]
  wire [62:0] _T_27 = _T_26 ? {{62'd0}, _T_11} : _T_25; // @[Mux.scala 80:57]
  wire  _T_28 = 4'h7 == io_alu_op; // @[Mux.scala 80:60]
  wire [62:0] _T_29 = _T_28 ? {{62'd0}, _T_12} : _T_27; // @[Mux.scala 80:57]
  wire  _T_30 = 4'h2 == io_alu_op; // @[Mux.scala 80:60]
  wire [62:0] _T_31 = _T_30 ? {{31'd0}, _T_13} : _T_29; // @[Mux.scala 80:57]
  wire  _T_32 = 4'h3 == io_alu_op; // @[Mux.scala 80:60]
  wire [62:0] _T_33 = _T_32 ? {{31'd0}, _T_14} : _T_31; // @[Mux.scala 80:57]
  wire  _T_34 = 4'h4 == io_alu_op; // @[Mux.scala 80:60]
  wire [62:0] _T_35 = _T_34 ? {{31'd0}, _T_15} : _T_33; // @[Mux.scala 80:57]
  wire  _T_36 = 4'ha == io_alu_op; // @[Mux.scala 80:60]
  wire [62:0] _T_37 = _T_36 ? {{31'd0}, io_A} : _T_35; // @[Mux.scala 80:57]
  wire [31:0] _T_40 = 32'h0 - io_B; // @[ALU.scala 60:38]
  wire [31:0] _T_41 = io_alu_op[0] ? _T_40 : io_B; // @[ALU.scala 60:23]
  assign io_out = _T_37[31:0]; // @[ALU.scala 47:10]
  assign io_sum = io_A + _T_41; // @[ALU.scala 60:10]
endmodule
