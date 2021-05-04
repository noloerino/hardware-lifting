`ifndef VERILATOR
module testbench;
  reg [4095:0] vcdfile;
  reg clock;
`else
module testbench(input clock, output reg genclock);
  initial genclock = 1;
`endif
  reg genclock = 1;
  reg [31:0] cycle = 0;
  reg [0:0] PI_io_nasti_b_bits_user;
  wire [0:0] PI_clock = clock;
  reg [0:0] PI_io_nasti_r_bits_user;
  reg [0:0] PI_reset;
  reg [1:0] PI_io_nasti_b_bits_resp;
  reg [0:0] PI_io_nasti_aw_ready;
  reg [0:0] PI_io_host_fromhost_valid;
  reg [0:0] PI_io_nasti_r_bits_last;
  reg [0:0] PI_io_nasti_b_valid;
  reg [31:0] PI_io_host_fromhost_bits;
  reg [1:0] PI_io_nasti_r_bits_resp;
  reg [63:0] PI_io_nasti_r_bits_data;
  reg [0:0] PI_io_nasti_w_ready;
  reg [4:0] PI_io_nasti_r_bits_id;
  reg [0:0] PI_io_nasti_r_valid;
  reg [4:0] PI_io_nasti_b_bits_id;
  reg [0:0] PI_io_nasti_ar_ready;
  Tile UUT (
    .io_nasti_b_bits_user(PI_io_nasti_b_bits_user),
    .clock(PI_clock),
    .io_nasti_r_bits_user(PI_io_nasti_r_bits_user),
    .reset(PI_reset),
    .io_nasti_b_bits_resp(PI_io_nasti_b_bits_resp),
    .io_nasti_aw_ready(PI_io_nasti_aw_ready),
    .io_host_fromhost_valid(PI_io_host_fromhost_valid),
    .io_nasti_r_bits_last(PI_io_nasti_r_bits_last),
    .io_nasti_b_valid(PI_io_nasti_b_valid),
    .io_host_fromhost_bits(PI_io_host_fromhost_bits),
    .io_nasti_r_bits_resp(PI_io_nasti_r_bits_resp),
    .io_nasti_r_bits_data(PI_io_nasti_r_bits_data),
    .io_nasti_w_ready(PI_io_nasti_w_ready),
    .io_nasti_r_bits_id(PI_io_nasti_r_bits_id),
    .io_nasti_r_valid(PI_io_nasti_r_valid),
    .io_nasti_b_bits_id(PI_io_nasti_b_bits_id),
    .io_nasti_ar_ready(PI_io_nasti_ar_ready)
  );
`ifndef VERILATOR
  initial begin
    if ($value$plusargs("vcd=%s", vcdfile)) begin
      $dumpfile(vcdfile);
      $dumpvars(0, testbench);
    end
    #5 clock = 0;
    while (genclock) begin
      #5 clock = 0;
      #5 clock = 1;
    end
  end
`endif
  initial begin
`ifndef VERILATOR
    #1;
`endif
    // UUT.$0$past$__lft__corr.\v:6622$3$1[0:0]$23  = 1'b0;
    // UUT.$formal$__lft__corr.\v:6623$7_CHECK  = 1'b0;
    // UUT.$formal$__lft__corr.\v:6623$7_EN  = 1'b0;
    // UUT.$past$__lft__corr.\v:6622$3$1  = 1'b0;
    UUT.arb.state = 3'b001;
    UUT.core.dpath.csr.IE = 1'b0;
    UUT.core.dpath.csr.IE1 = 1'b0;
    UUT.core.dpath.csr.MSIE = 1'b0;
    UUT.core.dpath.csr.MSIP = 1'b1;
    UUT.core.dpath.csr.MTIE = 1'b1;
    UUT.core.dpath.csr.MTIP = 1'b0;
    UUT.core.dpath.csr.PRV = 2'b00;
    UUT.core.dpath.csr.PRV1 = 2'b01;
    UUT.core.dpath.csr.cycle = 32'b00000000000000000000000000000000;
    UUT.core.dpath.csr.cycleh = 32'b00000000000000000010000000000000;
    UUT.core.dpath.csr.instret = 32'b00000000000000010100000001100000;
    UUT.core.dpath.csr.instreth = 32'b00010000000000000000000000000000;
    UUT.core.dpath.csr.mbadaddr = 32'b00000000000000000000000000100000;
    UUT.core.dpath.csr.mcause = 32'b00000000000000000000000000000010;
    UUT.core.dpath.csr.mepc = 32'b00000000000000000000000000000000;
    UUT.core.dpath.csr.mfromhost = 32'b00000000000000000000000000010001;
    UUT.core.dpath.csr.mscratch = 32'b00000000000000000100000000000000;
    UUT.core.dpath.csr.mtimecmp = 32'b00000000000100000000000000000000;
    UUT.core.dpath.csr.mtohost = 32'b00001000000000000000000000000000;
    UUT.core.dpath.csr.time$ = 32'b00000000000000000000000000000001;
    UUT.core.dpath.csr.timeh = 32'b00000000000000010000000000000000;
    UUT.core.dpath.csr_cmd = 3'b000;
    UUT.core.dpath.csr_in = 32'b10000000000000000000000000000000;
    UUT.core.dpath.ew_alu = 32'b00000000000000000010000000000101;
    UUT.core.dpath.ew_inst = 32'b00110100000100001000101000000000;
    UUT.core.dpath.ew_pc = 33'b000000000000000000000000000000000;
    UUT.core.dpath.fe_inst = 32'b11000000011101000010001100010011;
    UUT.core.dpath.fe_pc = 33'b000000000000000000000000000000000;
    UUT.core.dpath.illegal = 1'b0;
    UUT.core.dpath.ld_type = 3'b101;
    UUT.core.dpath.pc = 33'b000000000000000000000000000000000;
    UUT.core.dpath.pc_check = 1'b0;
    UUT.core.dpath.st_type = 2'b11;
    UUT.core.dpath.started = 1'b0;
    UUT.core.dpath.wb_en = 1'b1;
    UUT.core.dpath.wb_sel = 2'b00;
    UUT.dcache.addr_reg = 32'b00000000000000000000000001000000;
    UUT.dcache.cpu_data = 32'b10101000000000000000000001000000;
    UUT.dcache.cpu_mask = 4'b1000;
    UUT.dcache.d = 256'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
    UUT.dcache.dataMem_3_3__T_210_addr_pipe_0 = 8'b00000000;
    UUT.dcache.is_alloc_reg = 1'b0;
    UUT.dcache.rdata_buf = 128'b00000000000000000000000001000000010000100000000001000000010000001010100000001000000000000000000001000010000000000100000001000000;
    UUT.dcache.refill_buf_0 = 64'b1010100000001000000000000000000001000010000000000100000001000000;
    UUT.dcache.refill_buf_1 = 64'b0000000000000000000000000100000001000010000000000100000001000000;
    UUT.dcache.ren_reg = 1'b0;
    UUT.dcache.state = 3'b010;
    UUT.dcache.v = 256'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010001;
    UUT.dcache.value = 1'b1;
    UUT.dcache.value_1 = 1'b0;
    UUT.icache.addr_reg = 32'b00100000000011000000001000100100;
    UUT.icache.cpu_data = 32'b00000010000010000000000000000000;
    UUT.icache.cpu_mask = 4'b0100;
    UUT.icache.d = 256'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
    UUT.icache.dataMem_3_3__T_210_addr_pipe_0 = 8'b10000100;
    UUT.icache.is_alloc_reg = 1'b1;
    UUT.icache.rdata_buf = 128'b00000000000000000000000001000000000000000000000001000010000000110000000001000000010000000000000000000010001000000000000000000000;
    UUT.icache.refill_buf_0 = 64'b0000000001000000010000000000000000000010001000000000000000000000;
    UUT.icache.refill_buf_1 = 64'b0000000000000000000000000100000000000000000010000000000001000000;
    UUT.icache.ren_reg = 1'b0;
    UUT.icache.state = 3'b000;
    UUT.icache.v = 256'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010100000000000000000000000000000100000000000000000001;
    UUT.icache.value = 1'b1;
    UUT.icache.value_1 = 1'b1;
    UUT.init = 1'b1;
    UUT.issued = 1'b0;
    UUT.tgt_rs2 = 32'b11111111111111111111111111111100;
    UUT.tgt_rs1 = 32'b00000000000000000000000000000100;
    UUT.core.dpath.regFile.regs[5'b00111] = 32'b00000000000000000000000000000000;
    UUT.core.dpath.regFile.regs[5'b01000] = 32'b11111111111111111111111111111100;
    UUT.core.dpath.regFile.regs[5'b00000] = 32'b11111111111111111111111111111100;
    UUT.core.dpath.regFile.regs[5'b10000] = 32'b00000000000000000000000000000100;
    UUT.core.dpath.regFile.regs[5'b00011] = 32'b01000000000000000000000000000000;
    UUT.core.dpath.regFile.regs[5'b00100] = 32'b00001111111111111111111111111101;
    UUT.dcache.dataMem_0_0[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_0_1[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_0_2[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_0_3[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_1_0[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_1_1[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_1_2[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_1_3[8'b00000000] = 8'b00001000;
    UUT.dcache.dataMem_2_0[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_2_1[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_2_2[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_2_3[8'b00000000] = 8'b01000010;
    UUT.dcache.dataMem_3_0[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_3_1[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_3_2[8'b00000000] = 8'b00000000;
    UUT.dcache.dataMem_3_3[8'b00000000] = 8'b00000000;
    UUT.dcache.metaMem_tag[8'b00000000] = 20'b00000000000000000000;
    UUT.icache.dataMem_0_0[8'b10000100] = 8'b00000000;
    UUT.icache.dataMem_0_0[8'b00100000] = 8'b00000000;
    UUT.icache.dataMem_0_1[8'b10000100] = 8'b00000000;
    UUT.icache.dataMem_0_1[8'b00100000] = 8'b00000000;
    UUT.icache.dataMem_0_2[8'b10000100] = 8'b10100000;
    UUT.icache.dataMem_0_2[8'b00100000] = 8'b10001000;
    UUT.icache.dataMem_0_3[8'b10000100] = 8'b01111000;
    UUT.icache.dataMem_0_3[8'b00100000] = 8'b00000000;
    UUT.icache.dataMem_1_0[8'b10000100] = 8'b00000000;
    UUT.icache.dataMem_1_0[8'b00100000] = 8'b00010011;
    UUT.icache.dataMem_1_1[8'b10000100] = 8'b00000000;
    UUT.icache.dataMem_1_1[8'b00100000] = 8'b00000100;
    UUT.icache.dataMem_1_2[8'b10000100] = 8'b00100000;
    UUT.icache.dataMem_1_2[8'b00100000] = 8'b00110010;
    UUT.icache.dataMem_1_3[8'b10000100] = 8'b10000000;
    UUT.icache.dataMem_1_3[8'b00100000] = 8'b00000000;
    UUT.icache.dataMem_2_0[8'b10000100] = 8'b00000000;
    UUT.icache.dataMem_2_0[8'b00100000] = 8'b01100000;
    UUT.icache.dataMem_2_1[8'b10000100] = 8'b00100000;
    UUT.icache.dataMem_2_1[8'b00100000] = 8'b01101011;
    UUT.icache.dataMem_2_2[8'b10000100] = 8'b00000000;
    UUT.icache.dataMem_2_2[8'b00100000] = 8'b00000000;
    UUT.icache.dataMem_2_3[8'b10000100] = 8'b00000000;
    UUT.icache.dataMem_2_3[8'b00100000] = 8'b00000000;
    UUT.icache.dataMem_3_0[8'b10000100] = 8'b00000000;
    UUT.icache.dataMem_3_0[8'b00100000] = 8'b00000000;
    UUT.icache.dataMem_3_1[8'b10000100] = 8'b00000000;
    UUT.icache.dataMem_3_1[8'b00100000] = 8'b00100000;
    UUT.icache.dataMem_3_2[8'b10000100] = 8'b00000000;
    UUT.icache.dataMem_3_2[8'b00100000] = 8'b00000000;
    UUT.icache.dataMem_3_3[8'b10000100] = 8'b00000001;
    UUT.icache.dataMem_3_3[8'b00100000] = 8'b00000000;
    UUT.icache.metaMem_tag[8'b10000100] = 20'b00100000000011000000;
    UUT.icache.metaMem_tag[8'b00100000] = 20'b10010010000001001000;

    // state 0
    PI_io_nasti_b_bits_user = 1'b0;
    PI_io_nasti_r_bits_user = 1'b0;
    PI_reset = 1'b1;
    PI_io_nasti_b_bits_resp = 2'b00;
    PI_io_nasti_aw_ready = 1'b0;
    PI_io_host_fromhost_valid = 1'b0;
    PI_io_nasti_r_bits_last = 1'b0;
    PI_io_nasti_b_valid = 1'b0;
    PI_io_host_fromhost_bits = 32'b00000000000000000000000000000000;
    PI_io_nasti_r_bits_resp = 2'b00;
    PI_io_nasti_r_bits_data = 64'b0000000000000000000000000100000000000000000010000000000001000000;
    PI_io_nasti_w_ready = 1'b0;
    PI_io_nasti_r_bits_id = 5'b00000;
    PI_io_nasti_r_valid = 1'b1;
    PI_io_nasti_b_bits_id = 5'b00000;
    PI_io_nasti_ar_ready = 1'b1;
  end
  always @(posedge clock) begin
    // state 1
    if (cycle == 0) begin
      PI_io_nasti_b_bits_user <= 1'b0;
      PI_io_nasti_r_bits_user <= 1'b0;
      PI_reset <= 1'b0;
      PI_io_nasti_b_bits_resp <= 2'b00;
      PI_io_nasti_aw_ready <= 1'b0;
      PI_io_host_fromhost_valid <= 1'b0;
      PI_io_nasti_r_bits_last <= 1'b0;
      PI_io_nasti_b_valid <= 1'b0;
      PI_io_host_fromhost_bits <= 32'b00000000000000000000000000010000;
      PI_io_nasti_r_bits_resp <= 2'b00;
      PI_io_nasti_r_bits_data <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      PI_io_nasti_w_ready <= 1'b0;
      PI_io_nasti_r_bits_id <= 5'b00000;
      PI_io_nasti_r_valid <= 1'b0;
      PI_io_nasti_b_bits_id <= 5'b00000;
      PI_io_nasti_ar_ready <= 1'b0;
    end

    // state 2
    if (cycle == 1) begin
      PI_io_nasti_b_bits_user <= 1'b0;
      PI_io_nasti_r_bits_user <= 1'b0;
      PI_reset <= 1'b0;
      PI_io_nasti_b_bits_resp <= 2'b00;
      PI_io_nasti_aw_ready <= 1'b0;
      PI_io_host_fromhost_valid <= 1'b1;
      PI_io_nasti_r_bits_last <= 1'b0;
      PI_io_nasti_b_valid <= 1'b0;
      PI_io_host_fromhost_bits <= 32'b00000000000000000000000000001000;
      PI_io_nasti_r_bits_resp <= 2'b00;
      PI_io_nasti_r_bits_data <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      PI_io_nasti_w_ready <= 1'b0;
      PI_io_nasti_r_bits_id <= 5'b00000;
      PI_io_nasti_r_valid <= 1'b0;
      PI_io_nasti_b_bits_id <= 5'b00000;
      PI_io_nasti_ar_ready <= 1'b1;
    end

    // state 3
    if (cycle == 2) begin
      PI_io_nasti_b_bits_user <= 1'b0;
      PI_io_nasti_r_bits_user <= 1'b0;
      PI_reset <= 1'b0;
      PI_io_nasti_b_bits_resp <= 2'b00;
      PI_io_nasti_aw_ready <= 1'b0;
      PI_io_host_fromhost_valid <= 1'b0;
      PI_io_nasti_r_bits_last <= 1'b0;
      PI_io_nasti_b_valid <= 1'b0;
      PI_io_host_fromhost_bits <= 32'b00000000000000000000000000000000;
      PI_io_nasti_r_bits_resp <= 2'b00;
      PI_io_nasti_r_bits_data <= 64'b0000000000110010000000000001001100000000100010000000000010110011;
      PI_io_nasti_w_ready <= 1'b0;
      PI_io_nasti_r_bits_id <= 5'b00000;
      PI_io_nasti_r_valid <= 1'b1;
      PI_io_nasti_b_bits_id <= 5'b00000;
      PI_io_nasti_ar_ready <= 1'b0;
    end

    // state 4
    if (cycle == 3) begin
      PI_io_nasti_b_bits_user <= 1'b0;
      PI_io_nasti_r_bits_user <= 1'b0;
      PI_reset <= 1'b0;
      PI_io_nasti_b_bits_resp <= 2'b00;
      PI_io_nasti_aw_ready <= 1'b0;
      PI_io_host_fromhost_valid <= 1'b0;
      PI_io_nasti_r_bits_last <= 1'b0;
      PI_io_nasti_b_valid <= 1'b0;
      PI_io_host_fromhost_bits <= 32'b00000000000000000000000000000000;
      PI_io_nasti_r_bits_resp <= 2'b00;
      PI_io_nasti_r_bits_data <= 64'b0000000000000000000000000000000000000000000000000110101101100011;
      PI_io_nasti_w_ready <= 1'b0;
      PI_io_nasti_r_bits_id <= 5'b00000;
      PI_io_nasti_r_valid <= 1'b1;
      PI_io_nasti_b_bits_id <= 5'b00000;
      PI_io_nasti_ar_ready <= 1'b1;
    end

    // state 5
    if (cycle == 4) begin
      PI_io_nasti_b_bits_user <= 1'b0;
      PI_io_nasti_r_bits_user <= 1'b0;
      PI_reset <= 1'b0;
      PI_io_nasti_b_bits_resp <= 2'b00;
      PI_io_nasti_aw_ready <= 1'b1;
      PI_io_host_fromhost_valid <= 1'b0;
      PI_io_nasti_r_bits_last <= 1'b0;
      PI_io_nasti_b_valid <= 1'b0;
      PI_io_host_fromhost_bits <= 32'b00000000000000000000000000000000;
      PI_io_nasti_r_bits_resp <= 2'b00;
      PI_io_nasti_r_bits_data <= 64'b0000000000110010000000000001001100000000100010000000000010110011;
      PI_io_nasti_w_ready <= 1'b0;
      PI_io_nasti_r_bits_id <= 5'b00000;
      PI_io_nasti_r_valid <= 1'b1;
      PI_io_nasti_b_bits_id <= 5'b00000;
      PI_io_nasti_ar_ready <= 1'b0;
    end

    // state 6
    if (cycle == 5) begin
      PI_io_nasti_b_bits_user <= 1'b0;
      PI_io_nasti_r_bits_user <= 1'b0;
      PI_reset <= 1'b0;
      PI_io_nasti_b_bits_resp <= 2'b00;
      PI_io_nasti_aw_ready <= 1'b0;
      PI_io_host_fromhost_valid <= 1'b0;
      PI_io_nasti_r_bits_last <= 1'b0;
      PI_io_nasti_b_valid <= 1'b0;
      PI_io_host_fromhost_bits <= 32'b00000000000000000000000000000000;
      PI_io_nasti_r_bits_resp <= 2'b00;
      PI_io_nasti_r_bits_data <= 64'b0000000000000000000000000000000000000000000000000110101101100011;
      PI_io_nasti_w_ready <= 1'b0;
      PI_io_nasti_r_bits_id <= 5'b00000;
      PI_io_nasti_r_valid <= 1'b1;
      PI_io_nasti_b_bits_id <= 5'b00000;
      PI_io_nasti_ar_ready <= 1'b0;
    end

    // state 7
    if (cycle == 6) begin
      PI_io_nasti_b_bits_user <= 1'b0;
      PI_io_nasti_r_bits_user <= 1'b0;
      PI_reset <= 1'b0;
      PI_io_nasti_b_bits_resp <= 2'b00;
      PI_io_nasti_aw_ready <= 1'b0;
      PI_io_host_fromhost_valid <= 1'b0;
      PI_io_nasti_r_bits_last <= 1'b0;
      PI_io_nasti_b_valid <= 1'b0;
      PI_io_host_fromhost_bits <= 32'b00000000000000000000000000000000;
      PI_io_nasti_r_bits_resp <= 2'b00;
      PI_io_nasti_r_bits_data <= 64'b0000000000000000000000000000000000000000000000000110101101100011;
      PI_io_nasti_w_ready <= 1'b0;
      PI_io_nasti_r_bits_id <= 5'b00000;
      PI_io_nasti_r_valid <= 1'b1;
      PI_io_nasti_b_bits_id <= 5'b00000;
      PI_io_nasti_ar_ready <= 1'b0;
    end

    // state 8
    if (cycle == 7) begin
      PI_io_nasti_b_bits_user <= 1'b0;
      PI_io_nasti_r_bits_user <= 1'b0;
      PI_reset <= 1'b0;
      PI_io_nasti_b_bits_resp <= 2'b00;
      PI_io_nasti_aw_ready <= 1'b0;
      PI_io_host_fromhost_valid <= 1'b0;
      PI_io_nasti_r_bits_last <= 1'b0;
      PI_io_nasti_b_valid <= 1'b0;
      PI_io_host_fromhost_bits <= 32'b00000000000000000000000000000000;
      PI_io_nasti_r_bits_resp <= 2'b00;
      PI_io_nasti_r_bits_data <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      PI_io_nasti_w_ready <= 1'b0;
      PI_io_nasti_r_bits_id <= 5'b00000;
      PI_io_nasti_r_valid <= 1'b0;
      PI_io_nasti_b_bits_id <= 5'b00000;
      PI_io_nasti_ar_ready <= 1'b0;
    end

    genclock <= cycle < 8;
    cycle <= cycle + 1;
  end
endmodule
