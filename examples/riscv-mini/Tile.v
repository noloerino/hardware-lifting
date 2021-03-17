module CSR(
  input         clock,
  input         reset,
  input         io_stall,
  input  [2:0]  io_cmd,
  input  [31:0] io_in,
  output [31:0] io_out,
  input  [31:0] io_pc,
  input  [31:0] io_addr,
  input  [31:0] io_inst,
  input         io_illegal,
  input  [1:0]  io_st_type,
  input  [2:0]  io_ld_type,
  input         io_pc_check,
  output        io_expt,
  output [31:0] io_evec,
  output [31:0] io_epc,
  input         io_host_fromhost_valid,
  input  [31:0] io_host_fromhost_bits,
  output [31:0] io_host_tohost
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
`endif // RANDOMIZE_REG_INIT
  wire [11:0] csr_addr = io_inst[31:20]; // @[CSR.scala 100:25]
  wire [4:0] rs1_addr = io_inst[19:15]; // @[CSR.scala 101:25]
  reg [31:0] time_; // @[CSR.scala 104:25]
  reg [31:0] timeh; // @[CSR.scala 105:25]
  reg [31:0] cycle; // @[CSR.scala 106:25]
  reg [31:0] cycleh; // @[CSR.scala 107:25]
  reg [31:0] instret; // @[CSR.scala 108:25]
  reg [31:0] instreth; // @[CSR.scala 109:25]
  reg [1:0] PRV; // @[CSR.scala 118:21]
  reg [1:0] PRV1; // @[CSR.scala 119:21]
  reg  IE; // @[CSR.scala 122:20]
  reg  IE1; // @[CSR.scala 123:20]
  wire [31:0] mstatus = {22'h0,3'h0,1'h0,PRV1,IE1,PRV,IE}; // @[Cat.scala 30:58]
  reg  MTIP; // @[CSR.scala 139:21]
  reg  MTIE; // @[CSR.scala 142:21]
  reg  MSIP; // @[CSR.scala 145:21]
  reg  MSIE; // @[CSR.scala 148:21]
  wire [31:0] mip = {24'h0,MTIP,1'h0,2'h0,MSIP,1'h0,2'h0}; // @[Cat.scala 30:58]
  wire [31:0] mie = {24'h0,MTIE,1'h0,2'h0,MSIE,1'h0,2'h0}; // @[Cat.scala 30:58]
  reg [31:0] mtimecmp; // @[CSR.scala 154:21]
  reg [31:0] mscratch; // @[CSR.scala 156:21]
  reg [31:0] mepc; // @[CSR.scala 158:17]
  reg [31:0] mcause; // @[CSR.scala 159:19]
  reg [31:0] mbadaddr; // @[CSR.scala 160:21]
  reg [31:0] mtohost; // @[CSR.scala 162:24]
  reg [31:0] mfromhost; // @[CSR.scala 163:22]
  wire [31:0] _GEN_0 = io_host_fromhost_valid ? io_host_fromhost_bits : mfromhost; // @[CSR.scala 165:32]
  wire  _T_28 = 12'hc00 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_30 = 12'hc01 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_32 = 12'hc02 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_34 = 12'hc80 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_36 = 12'hc81 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_38 = 12'hc82 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_40 = 12'h900 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_42 = 12'h901 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_44 = 12'h902 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_46 = 12'h980 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_48 = 12'h981 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_50 = 12'h982 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_52 = 12'hf00 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_54 = 12'hf01 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_56 = 12'hf10 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_58 = 12'h301 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_60 = 12'h302 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_62 = 12'h304 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_64 = 12'h321 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_66 = 12'h701 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_68 = 12'h741 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_70 = 12'h340 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_72 = 12'h341 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_74 = 12'h342 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_76 = 12'h343 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_78 = 12'h344 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_80 = 12'h780 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_82 = 12'h781 == csr_addr; // @[Lookup.scala 31:38]
  wire  _T_84 = 12'h300 == csr_addr; // @[Lookup.scala 31:38]
  wire [31:0] _T_85 = _T_84 ? mstatus : 32'h0; // @[Lookup.scala 33:37]
  wire [31:0] _T_86 = _T_82 ? mfromhost : _T_85; // @[Lookup.scala 33:37]
  wire [31:0] _T_87 = _T_80 ? mtohost : _T_86; // @[Lookup.scala 33:37]
  wire [31:0] _T_88 = _T_78 ? mip : _T_87; // @[Lookup.scala 33:37]
  wire [31:0] _T_89 = _T_76 ? mbadaddr : _T_88; // @[Lookup.scala 33:37]
  wire [31:0] _T_90 = _T_74 ? mcause : _T_89; // @[Lookup.scala 33:37]
  wire [31:0] _T_91 = _T_72 ? mepc : _T_90; // @[Lookup.scala 33:37]
  wire [31:0] _T_92 = _T_70 ? mscratch : _T_91; // @[Lookup.scala 33:37]
  wire [31:0] _T_93 = _T_68 ? timeh : _T_92; // @[Lookup.scala 33:37]
  wire [31:0] _T_94 = _T_66 ? time_ : _T_93; // @[Lookup.scala 33:37]
  wire [31:0] _T_95 = _T_64 ? mtimecmp : _T_94; // @[Lookup.scala 33:37]
  wire [31:0] _T_96 = _T_62 ? mie : _T_95; // @[Lookup.scala 33:37]
  wire [31:0] _T_97 = _T_60 ? 32'h0 : _T_96; // @[Lookup.scala 33:37]
  wire [31:0] _T_98 = _T_58 ? 32'h100 : _T_97; // @[Lookup.scala 33:37]
  wire [31:0] _T_99 = _T_56 ? 32'h0 : _T_98; // @[Lookup.scala 33:37]
  wire [31:0] _T_100 = _T_54 ? 32'h0 : _T_99; // @[Lookup.scala 33:37]
  wire [31:0] _T_101 = _T_52 ? 32'h100100 : _T_100; // @[Lookup.scala 33:37]
  wire [31:0] _T_102 = _T_50 ? instreth : _T_101; // @[Lookup.scala 33:37]
  wire [31:0] _T_103 = _T_48 ? timeh : _T_102; // @[Lookup.scala 33:37]
  wire [31:0] _T_104 = _T_46 ? cycleh : _T_103; // @[Lookup.scala 33:37]
  wire [31:0] _T_105 = _T_44 ? instret : _T_104; // @[Lookup.scala 33:37]
  wire [31:0] _T_106 = _T_42 ? time_ : _T_105; // @[Lookup.scala 33:37]
  wire [31:0] _T_107 = _T_40 ? cycle : _T_106; // @[Lookup.scala 33:37]
  wire [31:0] _T_108 = _T_38 ? instreth : _T_107; // @[Lookup.scala 33:37]
  wire [31:0] _T_109 = _T_36 ? timeh : _T_108; // @[Lookup.scala 33:37]
  wire [31:0] _T_110 = _T_34 ? cycleh : _T_109; // @[Lookup.scala 33:37]
  wire [31:0] _T_111 = _T_32 ? instret : _T_110; // @[Lookup.scala 33:37]
  wire [31:0] _T_112 = _T_30 ? time_ : _T_111; // @[Lookup.scala 33:37]
  wire  privValid = csr_addr[9:8] <= PRV; // @[CSR.scala 203:34]
  wire  privInst = io_cmd == 3'h4; // @[CSR.scala 204:26]
  wire  _T_116 = ~csr_addr[0]; // @[CSR.scala 205:31]
  wire  _T_117 = privInst & _T_116; // @[CSR.scala 205:28]
  wire  _T_119 = ~csr_addr[8]; // @[CSR.scala 205:47]
  wire  isEcall = _T_117 & _T_119; // @[CSR.scala 205:44]
  wire  _T_121 = privInst & csr_addr[0]; // @[CSR.scala 206:28]
  wire  isEbreak = _T_121 & _T_119; // @[CSR.scala 206:44]
  wire  isEret = _T_117 & csr_addr[8]; // @[CSR.scala 207:44]
  wire  _T_186 = _T_28 | _T_30; // @[CSR.scala 208:61]
  wire  _T_187 = _T_186 | _T_32; // @[CSR.scala 208:61]
  wire  _T_188 = _T_187 | _T_34; // @[CSR.scala 208:61]
  wire  _T_189 = _T_188 | _T_36; // @[CSR.scala 208:61]
  wire  _T_190 = _T_189 | _T_38; // @[CSR.scala 208:61]
  wire  _T_191 = _T_190 | _T_40; // @[CSR.scala 208:61]
  wire  _T_192 = _T_191 | _T_42; // @[CSR.scala 208:61]
  wire  _T_193 = _T_192 | _T_44; // @[CSR.scala 208:61]
  wire  _T_194 = _T_193 | _T_46; // @[CSR.scala 208:61]
  wire  _T_195 = _T_194 | _T_48; // @[CSR.scala 208:61]
  wire  _T_196 = _T_195 | _T_50; // @[CSR.scala 208:61]
  wire  _T_197 = _T_196 | _T_52; // @[CSR.scala 208:61]
  wire  _T_198 = _T_197 | _T_54; // @[CSR.scala 208:61]
  wire  _T_199 = _T_198 | _T_56; // @[CSR.scala 208:61]
  wire  _T_200 = _T_199 | _T_58; // @[CSR.scala 208:61]
  wire  _T_201 = _T_200 | _T_60; // @[CSR.scala 208:61]
  wire  _T_202 = _T_201 | _T_62; // @[CSR.scala 208:61]
  wire  _T_203 = _T_202 | _T_64; // @[CSR.scala 208:61]
  wire  _T_204 = _T_203 | _T_66; // @[CSR.scala 208:61]
  wire  _T_205 = _T_204 | _T_68; // @[CSR.scala 208:61]
  wire  _T_206 = _T_205 | _T_70; // @[CSR.scala 208:61]
  wire  _T_207 = _T_206 | _T_72; // @[CSR.scala 208:61]
  wire  _T_208 = _T_207 | _T_74; // @[CSR.scala 208:61]
  wire  _T_209 = _T_208 | _T_76; // @[CSR.scala 208:61]
  wire  _T_210 = _T_209 | _T_78; // @[CSR.scala 208:61]
  wire  _T_211 = _T_210 | _T_80; // @[CSR.scala 208:61]
  wire  _T_212 = _T_211 | _T_82; // @[CSR.scala 208:61]
  wire  csrValid = _T_212 | _T_84; // @[CSR.scala 208:61]
  wire  _T_214 = &csr_addr[11:10]; // @[CSR.scala 209:36]
  wire  _T_215 = csr_addr == 12'h301; // @[CSR.scala 209:53]
  wire  _T_216 = _T_214 | _T_215; // @[CSR.scala 209:41]
  wire  _T_217 = csr_addr == 12'h302; // @[CSR.scala 209:79]
  wire  csrRO = _T_216 | _T_217; // @[CSR.scala 209:67]
  wire  _T_218 = io_cmd == 3'h1; // @[CSR.scala 210:26]
  wire  _T_220 = |rs1_addr; // @[CSR.scala 210:61]
  wire  _T_221 = io_cmd[1] & _T_220; // @[CSR.scala 210:49]
  wire  wen = _T_218 | _T_221; // @[CSR.scala 210:36]
  wire [31:0] _T_222 = io_out | io_in; // @[CSR.scala 213:22]
  wire [31:0] _T_223 = ~io_in; // @[CSR.scala 214:24]
  wire [31:0] _T_224 = io_out & _T_223; // @[CSR.scala 214:22]
  wire  _T_225 = 3'h1 == io_cmd; // @[Mux.scala 80:60]
  wire [31:0] _T_226 = _T_225 ? io_in : 32'h0; // @[Mux.scala 80:57]
  wire  _T_227 = 3'h2 == io_cmd; // @[Mux.scala 80:60]
  wire [31:0] _T_228 = _T_227 ? _T_222 : _T_226; // @[Mux.scala 80:57]
  wire  _T_229 = 3'h3 == io_cmd; // @[Mux.scala 80:60]
  wire [31:0] wdata = _T_229 ? _T_224 : _T_228; // @[Mux.scala 80:57]
  wire  iaddrInvalid = io_pc_check & io_addr[1]; // @[CSR.scala 216:34]
  wire  _T_232 = |io_addr[1:0]; // @[CSR.scala 218:36]
  wire  _T_235 = 3'h1 == io_ld_type; // @[Mux.scala 80:60]
  wire  _T_236 = _T_235 & _T_232; // @[Mux.scala 80:57]
  wire  _T_237 = 3'h2 == io_ld_type; // @[Mux.scala 80:60]
  wire  _T_238 = _T_237 ? io_addr[0] : _T_236; // @[Mux.scala 80:57]
  wire  _T_239 = 3'h4 == io_ld_type; // @[Mux.scala 80:60]
  wire  laddrInvalid = _T_239 ? io_addr[0] : _T_238; // @[Mux.scala 80:57]
  wire  _T_243 = 2'h1 == io_st_type; // @[Mux.scala 80:60]
  wire  _T_244 = _T_243 & _T_232; // @[Mux.scala 80:57]
  wire  _T_245 = 2'h2 == io_st_type; // @[Mux.scala 80:60]
  wire  saddrInvalid = _T_245 ? io_addr[0] : _T_244; // @[Mux.scala 80:57]
  wire  _T_246 = io_illegal | iaddrInvalid; // @[CSR.scala 221:25]
  wire  _T_247 = _T_246 | laddrInvalid; // @[CSR.scala 221:41]
  wire  _T_248 = _T_247 | saddrInvalid; // @[CSR.scala 221:57]
  wire  _T_250 = |io_cmd[1:0]; // @[CSR.scala 222:27]
  wire  _T_251 = ~csrValid; // @[CSR.scala 222:35]
  wire  _T_252 = ~privValid; // @[CSR.scala 222:48]
  wire  _T_253 = _T_251 | _T_252; // @[CSR.scala 222:45]
  wire  _T_254 = _T_250 & _T_253; // @[CSR.scala 222:31]
  wire  _T_255 = _T_248 | _T_254; // @[CSR.scala 221:73]
  wire  _T_256 = wen & csrRO; // @[CSR.scala 222:67]
  wire  _T_257 = _T_255 | _T_256; // @[CSR.scala 222:60]
  wire  _T_259 = privInst & _T_252; // @[CSR.scala 223:24]
  wire  _T_260 = _T_257 | _T_259; // @[CSR.scala 222:76]
  wire  _T_261 = _T_260 | isEcall; // @[CSR.scala 223:39]
  wire [7:0] _T_263 = {PRV, 6'h0}; // @[CSR.scala 224:27]
  wire [31:0] _GEN_260 = {{24'd0}, _T_263}; // @[CSR.scala 224:20]
  wire [31:0] _T_267 = time_ + 32'h1; // @[CSR.scala 228:16]
  wire  _T_268 = &time_; // @[CSR.scala 229:13]
  wire [31:0] _T_270 = timeh + 32'h1; // @[CSR.scala 229:36]
  wire [31:0] _GEN_1 = _T_268 ? _T_270 : timeh; // @[CSR.scala 229:19]
  wire [31:0] _T_272 = cycle + 32'h1; // @[CSR.scala 230:18]
  wire  _T_273 = &cycle; // @[CSR.scala 231:14]
  wire [31:0] _T_275 = cycleh + 32'h1; // @[CSR.scala 231:39]
  wire [31:0] _GEN_2 = _T_273 ? _T_275 : cycleh; // @[CSR.scala 231:20]
  wire  _T_276 = io_inst != 32'h13; // @[CSR.scala 232:27]
  wire  _T_277 = ~io_expt; // @[CSR.scala 232:52]
  wire  _T_278 = _T_277 | isEcall; // @[CSR.scala 232:61]
  wire  _T_279 = _T_278 | isEbreak; // @[CSR.scala 232:72]
  wire  _T_280 = _T_276 & _T_279; // @[CSR.scala 232:48]
  wire  _T_281 = ~io_stall; // @[CSR.scala 232:88]
  wire  isInstRet = _T_280 & _T_281; // @[CSR.scala 232:85]
  wire [31:0] _T_283 = instret + 32'h1; // @[CSR.scala 233:40]
  wire [31:0] _GEN_3 = isInstRet ? _T_283 : instret; // @[CSR.scala 233:19]
  wire  _T_284 = &instret; // @[CSR.scala 234:29]
  wire  _T_285 = isInstRet & _T_284; // @[CSR.scala 234:18]
  wire [31:0] _T_287 = instreth + 32'h1; // @[CSR.scala 234:58]
  wire [31:0] _GEN_4 = _T_285 ? _T_287 : instreth; // @[CSR.scala 234:35]
  wire [31:0] _T_290 = {io_pc[31:2], 2'h0}; // @[CSR.scala 238:28]
  wire [3:0] _GEN_261 = {{2'd0}, PRV}; // @[CSR.scala 242:47]
  wire [3:0] _T_292 = 4'h8 + _GEN_261; // @[CSR.scala 242:47]
  wire [1:0] _T_293 = isEbreak ? 2'h3 : 2'h2; // @[CSR.scala 243:20]
  wire [3:0] _T_294 = isEcall ? _T_292 : {{2'd0}, _T_293}; // @[CSR.scala 242:20]
  wire [3:0] _T_295 = saddrInvalid ? 4'h6 : _T_294; // @[CSR.scala 241:20]
  wire [3:0] _T_296 = laddrInvalid ? 4'h4 : _T_295; // @[CSR.scala 240:20]
  wire [3:0] _T_297 = iaddrInvalid ? 4'h0 : _T_296; // @[CSR.scala 239:20]
  wire  _T_298 = iaddrInvalid | laddrInvalid; // @[CSR.scala 248:25]
  wire  _T_299 = _T_298 | saddrInvalid; // @[CSR.scala 248:41]
  wire  _T_300 = csr_addr == 12'h300; // @[CSR.scala 255:21]
  wire  _T_305 = csr_addr == 12'h344; // @[CSR.scala 261:26]
  wire  _T_308 = csr_addr == 12'h304; // @[CSR.scala 265:26]
  wire  _T_311 = csr_addr == 12'h701; // @[CSR.scala 269:26]
  wire  _T_312 = csr_addr == 12'h741; // @[CSR.scala 270:26]
  wire  _T_313 = csr_addr == 12'h321; // @[CSR.scala 271:26]
  wire  _T_314 = csr_addr == 12'h340; // @[CSR.scala 272:26]
  wire  _T_315 = csr_addr == 12'h341; // @[CSR.scala 273:26]
  wire [31:0] _T_316 = {{2'd0}, wdata[31:2]}; // @[CSR.scala 273:56]
  wire [33:0] _GEN_263 = {_T_316, 2'h0}; // @[CSR.scala 273:63]
  wire [34:0] _T_317 = {{1'd0}, _GEN_263}; // @[CSR.scala 273:63]
  wire  _T_318 = csr_addr == 12'h342; // @[CSR.scala 274:26]
  wire [31:0] _T_319 = wdata & 32'h8000000f; // @[CSR.scala 274:60]
  wire  _T_320 = csr_addr == 12'h343; // @[CSR.scala 275:26]
  wire  _T_321 = csr_addr == 12'h780; // @[CSR.scala 276:26]
  wire  _T_322 = csr_addr == 12'h781; // @[CSR.scala 277:26]
  wire  _T_323 = csr_addr == 12'h900; // @[CSR.scala 278:26]
  wire  _T_324 = csr_addr == 12'h901; // @[CSR.scala 279:26]
  wire  _T_325 = csr_addr == 12'h902; // @[CSR.scala 280:26]
  wire  _T_326 = csr_addr == 12'h980; // @[CSR.scala 281:26]
  wire  _T_327 = csr_addr == 12'h981; // @[CSR.scala 282:26]
  wire  _T_328 = csr_addr == 12'h982; // @[CSR.scala 283:26]
  wire [34:0] _GEN_61 = _T_315 ? _T_317 : {{3'd0}, mepc}; // @[CSR.scala 273:40]
  wire [34:0] _GEN_73 = _T_314 ? {{3'd0}, mepc} : _GEN_61; // @[CSR.scala 272:44]
  wire [34:0] _GEN_86 = _T_313 ? {{3'd0}, mepc} : _GEN_73; // @[CSR.scala 271:44]
  wire [34:0] _GEN_100 = _T_312 ? {{3'd0}, mepc} : _GEN_86; // @[CSR.scala 270:42]
  wire [34:0] _GEN_114 = _T_311 ? {{3'd0}, mepc} : _GEN_100; // @[CSR.scala 269:41]
  wire [34:0] _GEN_129 = _T_308 ? {{3'd0}, mepc} : _GEN_114; // @[CSR.scala 265:39]
  wire [34:0] _GEN_146 = _T_305 ? {{3'd0}, mepc} : _GEN_129; // @[CSR.scala 261:39]
  wire  _GEN_156 = _T_300 ? wdata[3] : IE1; // @[CSR.scala 255:38]
  wire [34:0] _GEN_167 = _T_300 ? {{3'd0}, mepc} : _GEN_146; // @[CSR.scala 255:38]
  wire  _GEN_177 = wen ? _GEN_156 : IE1; // @[CSR.scala 254:21]
  wire [34:0] _GEN_188 = wen ? _GEN_167 : {{3'd0}, mepc}; // @[CSR.scala 254:21]
  wire  _GEN_200 = isEret | _GEN_177; // @[CSR.scala 249:24]
  wire [34:0] _GEN_209 = isEret ? {{3'd0}, mepc} : _GEN_188; // @[CSR.scala 249:24]
  wire [34:0] _GEN_218 = io_expt ? {{3'd0}, _T_290} : _GEN_209; // @[CSR.scala 237:19]
  wire [34:0] _GEN_239 = _T_281 ? _GEN_218 : {{3'd0}, mepc}; // @[CSR.scala 236:19]
  assign io_out = _T_28 ? cycle : _T_112; // @[CSR.scala 201:10]
  assign io_expt = _T_261 | isEbreak; // @[CSR.scala 221:11]
  assign io_evec = 32'h100 + _GEN_260; // @[CSR.scala 224:11]
  assign io_epc = mepc; // @[CSR.scala 225:11]
  assign io_host_tohost = mtohost; // @[CSR.scala 164:18]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  time_ = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  timeh = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  cycle = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  cycleh = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  instret = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  instreth = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  PRV = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  PRV1 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  IE = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  IE1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  MTIP = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  MTIE = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  MSIP = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  MSIE = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  mtimecmp = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  mscratch = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  mepc = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  mcause = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  mbadaddr = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  mtohost = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  mfromhost = _RAND_20[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      time_ <= 32'h0;
    end else if (_T_281) begin
      if (io_expt) begin
        time_ <= _T_267;
      end else if (isEret) begin
        time_ <= _T_267;
      end else if (wen) begin
        if (_T_300) begin
          time_ <= _T_267;
        end else if (_T_305) begin
          time_ <= _T_267;
        end else if (_T_308) begin
          time_ <= _T_267;
        end else if (_T_311) begin
          if (_T_229) begin
            time_ <= _T_224;
          end else if (_T_227) begin
            time_ <= _T_222;
          end else if (_T_225) begin
            time_ <= io_in;
          end else begin
            time_ <= 32'h0;
          end
        end else if (_T_312) begin
          time_ <= _T_267;
        end else if (_T_313) begin
          time_ <= _T_267;
        end else if (_T_314) begin
          time_ <= _T_267;
        end else if (_T_315) begin
          time_ <= _T_267;
        end else if (_T_318) begin
          time_ <= _T_267;
        end else if (_T_320) begin
          time_ <= _T_267;
        end else if (_T_321) begin
          time_ <= _T_267;
        end else if (_T_322) begin
          time_ <= _T_267;
        end else if (_T_323) begin
          time_ <= _T_267;
        end else if (_T_324) begin
          if (_T_229) begin
            time_ <= _T_224;
          end else if (_T_227) begin
            time_ <= _T_222;
          end else if (_T_225) begin
            time_ <= io_in;
          end else begin
            time_ <= 32'h0;
          end
        end else begin
          time_ <= _T_267;
        end
      end else begin
        time_ <= _T_267;
      end
    end else begin
      time_ <= _T_267;
    end
    if (reset) begin
      timeh <= 32'h0;
    end else if (_T_281) begin
      if (io_expt) begin
        if (_T_268) begin
          timeh <= _T_270;
        end
      end else if (isEret) begin
        if (_T_268) begin
          timeh <= _T_270;
        end
      end else if (wen) begin
        if (_T_300) begin
          if (_T_268) begin
            timeh <= _T_270;
          end
        end else if (_T_305) begin
          if (_T_268) begin
            timeh <= _T_270;
          end
        end else if (_T_308) begin
          timeh <= _GEN_1;
        end else if (_T_311) begin
          timeh <= _GEN_1;
        end else if (_T_312) begin
          if (_T_229) begin
            timeh <= _T_224;
          end else if (_T_227) begin
            timeh <= _T_222;
          end else if (_T_225) begin
            timeh <= io_in;
          end else begin
            timeh <= 32'h0;
          end
        end else if (_T_313) begin
          timeh <= _GEN_1;
        end else if (_T_314) begin
          timeh <= _GEN_1;
        end else if (_T_315) begin
          timeh <= _GEN_1;
        end else if (_T_318) begin
          timeh <= _GEN_1;
        end else if (_T_320) begin
          timeh <= _GEN_1;
        end else if (_T_321) begin
          timeh <= _GEN_1;
        end else if (_T_322) begin
          timeh <= _GEN_1;
        end else if (_T_323) begin
          timeh <= _GEN_1;
        end else if (_T_324) begin
          timeh <= _GEN_1;
        end else if (_T_325) begin
          timeh <= _GEN_1;
        end else if (_T_326) begin
          timeh <= _GEN_1;
        end else if (_T_327) begin
          if (_T_229) begin
            timeh <= _T_224;
          end else if (_T_227) begin
            timeh <= _T_222;
          end else if (_T_225) begin
            timeh <= io_in;
          end else begin
            timeh <= 32'h0;
          end
        end else begin
          timeh <= _GEN_1;
        end
      end else begin
        timeh <= _GEN_1;
      end
    end else begin
      timeh <= _GEN_1;
    end
    if (reset) begin
      cycle <= 32'h0;
    end else if (_T_281) begin
      if (io_expt) begin
        cycle <= _T_272;
      end else if (isEret) begin
        cycle <= _T_272;
      end else if (wen) begin
        if (_T_300) begin
          cycle <= _T_272;
        end else if (_T_305) begin
          cycle <= _T_272;
        end else if (_T_308) begin
          cycle <= _T_272;
        end else if (_T_311) begin
          cycle <= _T_272;
        end else if (_T_312) begin
          cycle <= _T_272;
        end else if (_T_313) begin
          cycle <= _T_272;
        end else if (_T_314) begin
          cycle <= _T_272;
        end else if (_T_315) begin
          cycle <= _T_272;
        end else if (_T_318) begin
          cycle <= _T_272;
        end else if (_T_320) begin
          cycle <= _T_272;
        end else if (_T_321) begin
          cycle <= _T_272;
        end else if (_T_322) begin
          cycle <= _T_272;
        end else if (_T_323) begin
          cycle <= wdata;
        end else begin
          cycle <= _T_272;
        end
      end else begin
        cycle <= _T_272;
      end
    end else begin
      cycle <= _T_272;
    end
    if (reset) begin
      cycleh <= 32'h0;
    end else if (_T_281) begin
      if (io_expt) begin
        if (_T_273) begin
          cycleh <= _T_275;
        end
      end else if (isEret) begin
        if (_T_273) begin
          cycleh <= _T_275;
        end
      end else if (wen) begin
        if (_T_300) begin
          if (_T_273) begin
            cycleh <= _T_275;
          end
        end else if (_T_305) begin
          if (_T_273) begin
            cycleh <= _T_275;
          end
        end else if (_T_308) begin
          cycleh <= _GEN_2;
        end else if (_T_311) begin
          cycleh <= _GEN_2;
        end else if (_T_312) begin
          cycleh <= _GEN_2;
        end else if (_T_313) begin
          cycleh <= _GEN_2;
        end else if (_T_314) begin
          cycleh <= _GEN_2;
        end else if (_T_315) begin
          cycleh <= _GEN_2;
        end else if (_T_318) begin
          cycleh <= _GEN_2;
        end else if (_T_320) begin
          cycleh <= _GEN_2;
        end else if (_T_321) begin
          cycleh <= _GEN_2;
        end else if (_T_322) begin
          cycleh <= _GEN_2;
        end else if (_T_323) begin
          cycleh <= _GEN_2;
        end else if (_T_324) begin
          cycleh <= _GEN_2;
        end else if (_T_325) begin
          cycleh <= _GEN_2;
        end else if (_T_326) begin
          cycleh <= wdata;
        end else begin
          cycleh <= _GEN_2;
        end
      end else begin
        cycleh <= _GEN_2;
      end
    end else begin
      cycleh <= _GEN_2;
    end
    if (reset) begin
      instret <= 32'h0;
    end else if (_T_281) begin
      if (io_expt) begin
        if (isInstRet) begin
          instret <= _T_283;
        end
      end else if (isEret) begin
        if (isInstRet) begin
          instret <= _T_283;
        end
      end else if (wen) begin
        if (_T_300) begin
          if (isInstRet) begin
            instret <= _T_283;
          end
        end else if (_T_305) begin
          if (isInstRet) begin
            instret <= _T_283;
          end
        end else if (_T_308) begin
          instret <= _GEN_3;
        end else if (_T_311) begin
          instret <= _GEN_3;
        end else if (_T_312) begin
          instret <= _GEN_3;
        end else if (_T_313) begin
          instret <= _GEN_3;
        end else if (_T_314) begin
          instret <= _GEN_3;
        end else if (_T_315) begin
          instret <= _GEN_3;
        end else if (_T_318) begin
          instret <= _GEN_3;
        end else if (_T_320) begin
          instret <= _GEN_3;
        end else if (_T_321) begin
          instret <= _GEN_3;
        end else if (_T_322) begin
          instret <= _GEN_3;
        end else if (_T_323) begin
          instret <= _GEN_3;
        end else if (_T_324) begin
          instret <= _GEN_3;
        end else if (_T_325) begin
          instret <= wdata;
        end else begin
          instret <= _GEN_3;
        end
      end else begin
        instret <= _GEN_3;
      end
    end else begin
      instret <= _GEN_3;
    end
    if (reset) begin
      instreth <= 32'h0;
    end else if (_T_281) begin
      if (io_expt) begin
        if (_T_285) begin
          instreth <= _T_287;
        end
      end else if (isEret) begin
        if (_T_285) begin
          instreth <= _T_287;
        end
      end else if (wen) begin
        if (_T_300) begin
          if (_T_285) begin
            instreth <= _T_287;
          end
        end else if (_T_305) begin
          if (_T_285) begin
            instreth <= _T_287;
          end
        end else if (_T_308) begin
          instreth <= _GEN_4;
        end else if (_T_311) begin
          instreth <= _GEN_4;
        end else if (_T_312) begin
          instreth <= _GEN_4;
        end else if (_T_313) begin
          instreth <= _GEN_4;
        end else if (_T_314) begin
          instreth <= _GEN_4;
        end else if (_T_315) begin
          instreth <= _GEN_4;
        end else if (_T_318) begin
          instreth <= _GEN_4;
        end else if (_T_320) begin
          instreth <= _GEN_4;
        end else if (_T_321) begin
          instreth <= _GEN_4;
        end else if (_T_322) begin
          instreth <= _GEN_4;
        end else if (_T_323) begin
          instreth <= _GEN_4;
        end else if (_T_324) begin
          instreth <= _GEN_4;
        end else if (_T_325) begin
          instreth <= _GEN_4;
        end else if (_T_326) begin
          instreth <= _GEN_4;
        end else if (_T_327) begin
          instreth <= _GEN_4;
        end else if (_T_328) begin
          instreth <= wdata;
        end else begin
          instreth <= _GEN_4;
        end
      end else begin
        instreth <= _GEN_4;
      end
    end else begin
      instreth <= _GEN_4;
    end
    if (reset) begin
      PRV <= 2'h3;
    end else if (_T_281) begin
      if (io_expt) begin
        PRV <= 2'h3;
      end else if (isEret) begin
        PRV <= PRV1;
      end else if (wen) begin
        if (_T_300) begin
          PRV <= wdata[2:1];
        end
      end
    end
    if (reset) begin
      PRV1 <= 2'h3;
    end else if (_T_281) begin
      if (io_expt) begin
        PRV1 <= PRV;
      end else if (isEret) begin
        PRV1 <= 2'h0;
      end else if (wen) begin
        if (_T_300) begin
          PRV1 <= wdata[5:4];
        end
      end
    end
    if (reset) begin
      IE <= 1'h0;
    end else if (_T_281) begin
      if (io_expt) begin
        IE <= 1'h0;
      end else if (isEret) begin
        IE <= IE1;
      end else if (wen) begin
        if (_T_300) begin
          IE <= wdata[0];
        end
      end
    end
    if (reset) begin
      IE1 <= 1'h0;
    end else if (_T_281) begin
      if (io_expt) begin
        IE1 <= IE;
      end else begin
        IE1 <= _GEN_200;
      end
    end
    if (reset) begin
      MTIP <= 1'h0;
    end else if (_T_281) begin
      if (!(io_expt)) begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_300)) begin
              if (_T_305) begin
                MTIP <= wdata[7];
              end
            end
          end
        end
      end
    end
    if (reset) begin
      MTIE <= 1'h0;
    end else if (_T_281) begin
      if (!(io_expt)) begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_300)) begin
              if (!(_T_305)) begin
                if (_T_308) begin
                  MTIE <= wdata[7];
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      MSIP <= 1'h0;
    end else if (_T_281) begin
      if (!(io_expt)) begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_300)) begin
              if (_T_305) begin
                MSIP <= wdata[3];
              end
            end
          end
        end
      end
    end
    if (reset) begin
      MSIE <= 1'h0;
    end else if (_T_281) begin
      if (!(io_expt)) begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_300)) begin
              if (!(_T_305)) begin
                if (_T_308) begin
                  MSIE <= wdata[3];
                end
              end
            end
          end
        end
      end
    end
    if (_T_281) begin
      if (!(io_expt)) begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_300)) begin
              if (!(_T_305)) begin
                if (!(_T_308)) begin
                  if (!(_T_311)) begin
                    if (!(_T_312)) begin
                      if (_T_313) begin
                        mtimecmp <= wdata;
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if (_T_281) begin
      if (!(io_expt)) begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_300)) begin
              if (!(_T_305)) begin
                if (!(_T_308)) begin
                  if (!(_T_311)) begin
                    if (!(_T_312)) begin
                      if (!(_T_313)) begin
                        if (_T_314) begin
                          mscratch <= wdata;
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    mepc <= _GEN_239[31:0];
    if (_T_281) begin
      if (io_expt) begin
        mcause <= {{28'd0}, _T_297};
      end else if (!(isEret)) begin
        if (wen) begin
          if (!(_T_300)) begin
            if (!(_T_305)) begin
              if (!(_T_308)) begin
                if (!(_T_311)) begin
                  if (!(_T_312)) begin
                    if (!(_T_313)) begin
                      if (!(_T_314)) begin
                        if (!(_T_315)) begin
                          if (_T_318) begin
                            mcause <= _T_319;
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if (_T_281) begin
      if (io_expt) begin
        if (_T_299) begin
          mbadaddr <= io_addr;
        end
      end else if (!(isEret)) begin
        if (wen) begin
          if (!(_T_300)) begin
            if (!(_T_305)) begin
              if (!(_T_308)) begin
                if (!(_T_311)) begin
                  if (!(_T_312)) begin
                    if (!(_T_313)) begin
                      if (!(_T_314)) begin
                        if (!(_T_315)) begin
                          if (!(_T_318)) begin
                            if (_T_320) begin
                              mbadaddr <= wdata;
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      mtohost <= 32'h0;
    end else if (_T_281) begin
      if (!(io_expt)) begin
        if (!(isEret)) begin
          if (wen) begin
            if (!(_T_300)) begin
              if (!(_T_305)) begin
                if (!(_T_308)) begin
                  if (!(_T_311)) begin
                    if (!(_T_312)) begin
                      if (!(_T_313)) begin
                        if (!(_T_314)) begin
                          if (!(_T_315)) begin
                            if (!(_T_318)) begin
                              if (!(_T_320)) begin
                                if (_T_321) begin
                                  mtohost <= wdata;
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    if (_T_281) begin
      if (io_expt) begin
        if (io_host_fromhost_valid) begin
          mfromhost <= io_host_fromhost_bits;
        end
      end else if (isEret) begin
        if (io_host_fromhost_valid) begin
          mfromhost <= io_host_fromhost_bits;
        end
      end else if (wen) begin
        if (_T_300) begin
          if (io_host_fromhost_valid) begin
            mfromhost <= io_host_fromhost_bits;
          end
        end else if (_T_305) begin
          if (io_host_fromhost_valid) begin
            mfromhost <= io_host_fromhost_bits;
          end
        end else if (_T_308) begin
          mfromhost <= _GEN_0;
        end else if (_T_311) begin
          mfromhost <= _GEN_0;
        end else if (_T_312) begin
          mfromhost <= _GEN_0;
        end else if (_T_313) begin
          mfromhost <= _GEN_0;
        end else if (_T_314) begin
          mfromhost <= _GEN_0;
        end else if (_T_315) begin
          mfromhost <= _GEN_0;
        end else if (_T_318) begin
          mfromhost <= _GEN_0;
        end else if (_T_320) begin
          mfromhost <= _GEN_0;
        end else if (_T_321) begin
          mfromhost <= _GEN_0;
        end else if (_T_322) begin
          mfromhost <= wdata;
        end else begin
          mfromhost <= _GEN_0;
        end
      end else begin
        mfromhost <= _GEN_0;
      end
    end else begin
      mfromhost <= _GEN_0;
    end
  end
endmodule
module RegFile(
  input         clock,
  input  [4:0]  io_raddr1,
  input  [4:0]  io_raddr2,
  output [31:0] io_rdata1,
  output [31:0] io_rdata2,
  input         io_wen,
  input  [4:0]  io_waddr,
  input  [31:0] io_wdata
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [31:0] regs [0:31]; // @[RegFile.scala 20:17]
  wire [31:0] regs__T_1_data; // @[RegFile.scala 20:17]
  wire [4:0] regs__T_1_addr; // @[RegFile.scala 20:17]
  wire [31:0] regs__T_4_data; // @[RegFile.scala 20:17]
  wire [4:0] regs__T_4_addr; // @[RegFile.scala 20:17]
  wire [31:0] regs__T_8_data; // @[RegFile.scala 20:17]
  wire [4:0] regs__T_8_addr; // @[RegFile.scala 20:17]
  wire  regs__T_8_mask; // @[RegFile.scala 20:17]
  wire  regs__T_8_en; // @[RegFile.scala 20:17]
  wire  _T = |io_raddr1; // @[RegFile.scala 21:30]
  wire  _T_3 = |io_raddr2; // @[RegFile.scala 22:30]
  wire  _T_6 = |io_waddr; // @[RegFile.scala 23:26]
  assign regs__T_1_addr = io_raddr1;
  assign regs__T_1_data = regs[regs__T_1_addr]; // @[RegFile.scala 20:17]
  assign regs__T_4_addr = io_raddr2;
  assign regs__T_4_data = regs[regs__T_4_addr]; // @[RegFile.scala 20:17]
  assign regs__T_8_data = io_wdata;
  assign regs__T_8_addr = io_waddr;
  assign regs__T_8_mask = 1'h1;
  assign regs__T_8_en = io_wen & _T_6;
  assign io_rdata1 = _T ? regs__T_1_data : 32'h0; // @[RegFile.scala 21:13]
  assign io_rdata2 = _T_3 ? regs__T_4_data : 32'h0; // @[RegFile.scala 22:13]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regs[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(regs__T_8_en & regs__T_8_mask) begin
      regs[regs__T_8_addr] <= regs__T_8_data; // @[RegFile.scala 20:17]
    end
  end
endmodule
module ALUArea(
  input  [31:0] io_A,
  input  [31:0] io_B,
  input  [3:0]  io_alu_op,
  output [31:0] io_out,
  output [31:0] io_sum
);
  wire [31:0] _T_2 = 32'h0 - io_B; // @[ALU.scala 64:38]
  wire [31:0] _T_3 = io_alu_op[0] ? _T_2 : io_B; // @[ALU.scala 64:23]
  wire [31:0] sum = io_A + _T_3; // @[ALU.scala 64:18]
  wire  _T_7 = io_A[31] == io_B[31]; // @[ALU.scala 65:30]
  wire  _T_12 = io_alu_op[1] ? io_B[31] : io_A[31]; // @[ALU.scala 66:16]
  wire  cmp = _T_7 ? sum[31] : _T_12; // @[ALU.scala 65:16]
  wire [4:0] shamt = io_B[4:0]; // @[ALU.scala 67:20]
  wire [31:0] _T_17 = {{16'd0}, io_A[31:16]}; // @[Bitwise.scala 103:31]
  wire [31:0] _T_19 = {io_A[15:0], 16'h0}; // @[Bitwise.scala 103:65]
  wire [31:0] _T_21 = _T_19 & 32'hffff0000; // @[Bitwise.scala 103:75]
  wire [31:0] _T_22 = _T_17 | _T_21; // @[Bitwise.scala 103:39]
  wire [31:0] _GEN_0 = {{8'd0}, _T_22[31:8]}; // @[Bitwise.scala 103:31]
  wire [31:0] _T_27 = _GEN_0 & 32'hff00ff; // @[Bitwise.scala 103:31]
  wire [31:0] _T_29 = {_T_22[23:0], 8'h0}; // @[Bitwise.scala 103:65]
  wire [31:0] _T_31 = _T_29 & 32'hff00ff00; // @[Bitwise.scala 103:75]
  wire [31:0] _T_32 = _T_27 | _T_31; // @[Bitwise.scala 103:39]
  wire [31:0] _GEN_1 = {{4'd0}, _T_32[31:4]}; // @[Bitwise.scala 103:31]
  wire [31:0] _T_37 = _GEN_1 & 32'hf0f0f0f; // @[Bitwise.scala 103:31]
  wire [31:0] _T_39 = {_T_32[27:0], 4'h0}; // @[Bitwise.scala 103:65]
  wire [31:0] _T_41 = _T_39 & 32'hf0f0f0f0; // @[Bitwise.scala 103:75]
  wire [31:0] _T_42 = _T_37 | _T_41; // @[Bitwise.scala 103:39]
  wire [31:0] _GEN_2 = {{2'd0}, _T_42[31:2]}; // @[Bitwise.scala 103:31]
  wire [31:0] _T_47 = _GEN_2 & 32'h33333333; // @[Bitwise.scala 103:31]
  wire [31:0] _T_49 = {_T_42[29:0], 2'h0}; // @[Bitwise.scala 103:65]
  wire [31:0] _T_51 = _T_49 & 32'hcccccccc; // @[Bitwise.scala 103:75]
  wire [31:0] _T_52 = _T_47 | _T_51; // @[Bitwise.scala 103:39]
  wire [31:0] _GEN_3 = {{1'd0}, _T_52[31:1]}; // @[Bitwise.scala 103:31]
  wire [31:0] _T_57 = _GEN_3 & 32'h55555555; // @[Bitwise.scala 103:31]
  wire [31:0] _T_59 = {_T_52[30:0], 1'h0}; // @[Bitwise.scala 103:65]
  wire [31:0] _T_61 = _T_59 & 32'haaaaaaaa; // @[Bitwise.scala 103:75]
  wire [31:0] _T_62 = _T_57 | _T_61; // @[Bitwise.scala 103:39]
  wire [31:0] shin = io_alu_op[3] ? io_A : _T_62; // @[ALU.scala 68:19]
  wire  _T_65 = io_alu_op[0] & shin[31]; // @[ALU.scala 69:34]
  wire [32:0] _T_67 = {_T_65,shin}; // @[ALU.scala 69:57]
  wire [32:0] _T_68 = $signed(_T_67) >>> shamt; // @[ALU.scala 69:64]
  wire [31:0] shiftr = _T_68[31:0]; // @[ALU.scala 69:73]
  wire [31:0] _T_72 = {{16'd0}, shiftr[31:16]}; // @[Bitwise.scala 103:31]
  wire [31:0] _T_74 = {shiftr[15:0], 16'h0}; // @[Bitwise.scala 103:65]
  wire [31:0] _T_76 = _T_74 & 32'hffff0000; // @[Bitwise.scala 103:75]
  wire [31:0] _T_77 = _T_72 | _T_76; // @[Bitwise.scala 103:39]
  wire [31:0] _GEN_4 = {{8'd0}, _T_77[31:8]}; // @[Bitwise.scala 103:31]
  wire [31:0] _T_82 = _GEN_4 & 32'hff00ff; // @[Bitwise.scala 103:31]
  wire [31:0] _T_84 = {_T_77[23:0], 8'h0}; // @[Bitwise.scala 103:65]
  wire [31:0] _T_86 = _T_84 & 32'hff00ff00; // @[Bitwise.scala 103:75]
  wire [31:0] _T_87 = _T_82 | _T_86; // @[Bitwise.scala 103:39]
  wire [31:0] _GEN_5 = {{4'd0}, _T_87[31:4]}; // @[Bitwise.scala 103:31]
  wire [31:0] _T_92 = _GEN_5 & 32'hf0f0f0f; // @[Bitwise.scala 103:31]
  wire [31:0] _T_94 = {_T_87[27:0], 4'h0}; // @[Bitwise.scala 103:65]
  wire [31:0] _T_96 = _T_94 & 32'hf0f0f0f0; // @[Bitwise.scala 103:75]
  wire [31:0] _T_97 = _T_92 | _T_96; // @[Bitwise.scala 103:39]
  wire [31:0] _GEN_6 = {{2'd0}, _T_97[31:2]}; // @[Bitwise.scala 103:31]
  wire [31:0] _T_102 = _GEN_6 & 32'h33333333; // @[Bitwise.scala 103:31]
  wire [31:0] _T_104 = {_T_97[29:0], 2'h0}; // @[Bitwise.scala 103:65]
  wire [31:0] _T_106 = _T_104 & 32'hcccccccc; // @[Bitwise.scala 103:75]
  wire [31:0] _T_107 = _T_102 | _T_106; // @[Bitwise.scala 103:39]
  wire [31:0] _GEN_7 = {{1'd0}, _T_107[31:1]}; // @[Bitwise.scala 103:31]
  wire [31:0] _T_112 = _GEN_7 & 32'h55555555; // @[Bitwise.scala 103:31]
  wire [31:0] _T_114 = {_T_107[30:0], 1'h0}; // @[Bitwise.scala 103:65]
  wire [31:0] _T_116 = _T_114 & 32'haaaaaaaa; // @[Bitwise.scala 103:75]
  wire [31:0] shiftl = _T_112 | _T_116; // @[Bitwise.scala 103:39]
  wire  _T_117 = io_alu_op == 4'h0; // @[ALU.scala 73:19]
  wire  _T_118 = io_alu_op == 4'h1; // @[ALU.scala 73:44]
  wire  _T_119 = _T_117 | _T_118; // @[ALU.scala 73:31]
  wire  _T_120 = io_alu_op == 4'h5; // @[ALU.scala 74:19]
  wire  _T_121 = io_alu_op == 4'h7; // @[ALU.scala 74:44]
  wire  _T_122 = _T_120 | _T_121; // @[ALU.scala 74:31]
  wire  _T_123 = io_alu_op == 4'h9; // @[ALU.scala 75:19]
  wire  _T_124 = io_alu_op == 4'h8; // @[ALU.scala 75:44]
  wire  _T_125 = _T_123 | _T_124; // @[ALU.scala 75:31]
  wire  _T_126 = io_alu_op == 4'h6; // @[ALU.scala 76:19]
  wire  _T_127 = io_alu_op == 4'h2; // @[ALU.scala 77:19]
  wire [31:0] _T_128 = io_A & io_B; // @[ALU.scala 77:38]
  wire  _T_129 = io_alu_op == 4'h3; // @[ALU.scala 78:19]
  wire [31:0] _T_130 = io_A | io_B; // @[ALU.scala 78:38]
  wire  _T_131 = io_alu_op == 4'h4; // @[ALU.scala 79:19]
  wire [31:0] _T_132 = io_A ^ io_B; // @[ALU.scala 79:38]
  wire  _T_133 = io_alu_op == 4'ha; // @[ALU.scala 80:19]
  wire [31:0] _T_134 = _T_133 ? io_A : io_B; // @[ALU.scala 80:8]
  wire [31:0] _T_135 = _T_131 ? _T_132 : _T_134; // @[ALU.scala 79:8]
  wire [31:0] _T_136 = _T_129 ? _T_130 : _T_135; // @[ALU.scala 78:8]
  wire [31:0] _T_137 = _T_127 ? _T_128 : _T_136; // @[ALU.scala 77:8]
  wire [31:0] _T_138 = _T_126 ? shiftl : _T_137; // @[ALU.scala 76:8]
  wire [31:0] _T_139 = _T_125 ? shiftr : _T_138; // @[ALU.scala 75:8]
  wire [31:0] _T_140 = _T_122 ? {{31'd0}, cmp} : _T_139; // @[ALU.scala 74:8]
  assign io_out = _T_119 ? sum : _T_140; // @[ALU.scala 83:10]
  assign io_sum = io_A + _T_3; // @[ALU.scala 84:10]
endmodule
module ImmGenWire(
  input  [31:0] io_inst,
  input  [2:0]  io_sel,
  output [31:0] io_out
);
  wire [11:0] Iimm = io_inst[31:20]; // @[ImmGen.scala 21:30]
  wire [11:0] Simm = {io_inst[31:25],io_inst[11:7]}; // @[ImmGen.scala 22:50]
  wire [12:0] Bimm = {io_inst[31],io_inst[7],io_inst[30:25],io_inst[11:8],1'h0}; // @[ImmGen.scala 23:86]
  wire [31:0] Uimm = {io_inst[31:12],12'h0}; // @[ImmGen.scala 24:46]
  wire [20:0] Jimm = {io_inst[31],io_inst[19:12],io_inst[20],io_inst[30:25],io_inst[24:21],1'h0}; // @[ImmGen.scala 25:105]
  wire [5:0] Zimm = {1'b0,$signed(io_inst[19:15])}; // @[ImmGen.scala 26:30]
  wire [11:0] _T_26 = $signed(Iimm) & -12'sh2; // @[ImmGen.scala 28:36]
  wire  _T_27 = 3'h1 == io_sel; // @[Mux.scala 80:60]
  wire [11:0] _T_28 = _T_27 ? $signed(Iimm) : $signed(_T_26); // @[Mux.scala 80:57]
  wire  _T_29 = 3'h2 == io_sel; // @[Mux.scala 80:60]
  wire [11:0] _T_30 = _T_29 ? $signed(Simm) : $signed(_T_28); // @[Mux.scala 80:57]
  wire  _T_31 = 3'h5 == io_sel; // @[Mux.scala 80:60]
  wire [12:0] _T_32 = _T_31 ? $signed(Bimm) : $signed({{1{_T_30[11]}},_T_30}); // @[Mux.scala 80:57]
  wire  _T_33 = 3'h3 == io_sel; // @[Mux.scala 80:60]
  wire [31:0] _T_34 = _T_33 ? $signed(Uimm) : $signed({{19{_T_32[12]}},_T_32}); // @[Mux.scala 80:57]
  wire  _T_35 = 3'h4 == io_sel; // @[Mux.scala 80:60]
  wire [31:0] _T_36 = _T_35 ? $signed({{11{Jimm[20]}},Jimm}) : $signed(_T_34); // @[Mux.scala 80:57]
  wire  _T_37 = 3'h6 == io_sel; // @[Mux.scala 80:60]
  assign io_out = _T_37 ? $signed({{26{Zimm[5]}},Zimm}) : $signed(_T_36); // @[ImmGen.scala 28:10]
endmodule
module BrCondArea(
  input  [31:0] io_rs1,
  input  [31:0] io_rs2,
  input  [2:0]  io_br_type,
  output        io_taken
);
  wire [31:0] diff = io_rs1 - io_rs2; // @[BrCond.scala 37:21]
  wire  neq = |diff; // @[BrCond.scala 38:19]
  wire  eq = ~neq; // @[BrCond.scala 39:14]
  wire  isSameSign = io_rs1[31] == io_rs2[31]; // @[BrCond.scala 40:35]
  wire  lt = isSameSign ? diff[31] : io_rs1[31]; // @[BrCond.scala 41:17]
  wire  ltu = isSameSign ? diff[31] : io_rs2[31]; // @[BrCond.scala 42:17]
  wire  ge = ~lt; // @[BrCond.scala 43:14]
  wire  geu = ~ltu; // @[BrCond.scala 44:14]
  wire  _T_7 = io_br_type == 3'h3; // @[BrCond.scala 46:18]
  wire  _T_8 = _T_7 & eq; // @[BrCond.scala 46:29]
  wire  _T_9 = io_br_type == 3'h6; // @[BrCond.scala 47:18]
  wire  _T_10 = _T_9 & neq; // @[BrCond.scala 47:29]
  wire  _T_11 = _T_8 | _T_10; // @[BrCond.scala 46:36]
  wire  _T_12 = io_br_type == 3'h2; // @[BrCond.scala 48:18]
  wire  _T_13 = _T_12 & lt; // @[BrCond.scala 48:29]
  wire  _T_14 = _T_11 | _T_13; // @[BrCond.scala 47:37]
  wire  _T_15 = io_br_type == 3'h5; // @[BrCond.scala 49:18]
  wire  _T_16 = _T_15 & ge; // @[BrCond.scala 49:29]
  wire  _T_17 = _T_14 | _T_16; // @[BrCond.scala 48:36]
  wire  _T_18 = io_br_type == 3'h1; // @[BrCond.scala 50:18]
  wire  _T_19 = _T_18 & ltu; // @[BrCond.scala 50:30]
  wire  _T_20 = _T_17 | _T_19; // @[BrCond.scala 49:36]
  wire  _T_21 = io_br_type == 3'h4; // @[BrCond.scala 51:18]
  wire  _T_22 = _T_21 & geu; // @[BrCond.scala 51:30]
  assign io_taken = _T_20 | _T_22; // @[BrCond.scala 45:12]
endmodule
module Datapath(
  input         clock,
  input         reset,
  input         io_host_fromhost_valid,
  input  [31:0] io_host_fromhost_bits,
  output [31:0] io_host_tohost,
  output        io_icache_req_valid,
  output [31:0] io_icache_req_bits_addr,
  input         io_icache_resp_valid,
  input  [31:0] io_icache_resp_bits_data,
  output        io_dcache_abort,
  output        io_dcache_req_valid,
  output [31:0] io_dcache_req_bits_addr,
  output [31:0] io_dcache_req_bits_data,
  output [3:0]  io_dcache_req_bits_mask,
  input         io_dcache_resp_valid,
  input  [31:0] io_dcache_resp_bits_data,
  output [31:0] io_ctrl_inst,
  input  [1:0]  io_ctrl_pc_sel,
  input         io_ctrl_inst_kill,
  input         io_ctrl_A_sel,
  input         io_ctrl_B_sel,
  input  [2:0]  io_ctrl_imm_sel,
  input  [3:0]  io_ctrl_alu_op,
  input  [2:0]  io_ctrl_br_type,
  input  [1:0]  io_ctrl_st_type,
  input  [2:0]  io_ctrl_ld_type,
  input  [1:0]  io_ctrl_wb_sel,
  input         io_ctrl_wb_en,
  input  [2:0]  io_ctrl_csr_cmd,
  input         io_ctrl_illegal
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [63:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  wire  csr_clock; // @[Datapath.scala 23:23]
  wire  csr_reset; // @[Datapath.scala 23:23]
  wire  csr_io_stall; // @[Datapath.scala 23:23]
  wire [2:0] csr_io_cmd; // @[Datapath.scala 23:23]
  wire [31:0] csr_io_in; // @[Datapath.scala 23:23]
  wire [31:0] csr_io_out; // @[Datapath.scala 23:23]
  wire [31:0] csr_io_pc; // @[Datapath.scala 23:23]
  wire [31:0] csr_io_addr; // @[Datapath.scala 23:23]
  wire [31:0] csr_io_inst; // @[Datapath.scala 23:23]
  wire  csr_io_illegal; // @[Datapath.scala 23:23]
  wire [1:0] csr_io_st_type; // @[Datapath.scala 23:23]
  wire [2:0] csr_io_ld_type; // @[Datapath.scala 23:23]
  wire  csr_io_pc_check; // @[Datapath.scala 23:23]
  wire  csr_io_expt; // @[Datapath.scala 23:23]
  wire [31:0] csr_io_evec; // @[Datapath.scala 23:23]
  wire [31:0] csr_io_epc; // @[Datapath.scala 23:23]
  wire  csr_io_host_fromhost_valid; // @[Datapath.scala 23:23]
  wire [31:0] csr_io_host_fromhost_bits; // @[Datapath.scala 23:23]
  wire [31:0] csr_io_host_tohost; // @[Datapath.scala 23:23]
  wire  regFile_clock; // @[Datapath.scala 24:23]
  wire [4:0] regFile_io_raddr1; // @[Datapath.scala 24:23]
  wire [4:0] regFile_io_raddr2; // @[Datapath.scala 24:23]
  wire [31:0] regFile_io_rdata1; // @[Datapath.scala 24:23]
  wire [31:0] regFile_io_rdata2; // @[Datapath.scala 24:23]
  wire  regFile_io_wen; // @[Datapath.scala 24:23]
  wire [4:0] regFile_io_waddr; // @[Datapath.scala 24:23]
  wire [31:0] regFile_io_wdata; // @[Datapath.scala 24:23]
  wire [31:0] alu_io_A; // @[Config.scala 13:50]
  wire [31:0] alu_io_B; // @[Config.scala 13:50]
  wire [3:0] alu_io_alu_op; // @[Config.scala 13:50]
  wire [31:0] alu_io_out; // @[Config.scala 13:50]
  wire [31:0] alu_io_sum; // @[Config.scala 13:50]
  wire [31:0] immGen_io_inst; // @[Config.scala 14:50]
  wire [2:0] immGen_io_sel; // @[Config.scala 14:50]
  wire [31:0] immGen_io_out; // @[Config.scala 14:50]
  wire [31:0] brCond_io_rs1; // @[Config.scala 15:50]
  wire [31:0] brCond_io_rs2; // @[Config.scala 15:50]
  wire [2:0] brCond_io_br_type; // @[Config.scala 15:50]
  wire  brCond_io_taken; // @[Config.scala 15:50]
  reg [31:0] fe_inst; // @[Datapath.scala 32:24]
  reg [32:0] fe_pc; // @[Datapath.scala 33:20]
  reg [31:0] ew_inst; // @[Datapath.scala 36:24]
  reg [32:0] ew_pc; // @[Datapath.scala 37:20]
  reg [31:0] ew_alu; // @[Datapath.scala 38:20]
  reg [31:0] csr_in; // @[Datapath.scala 39:20]
  reg [1:0] st_type; // @[Datapath.scala 42:21]
  reg [2:0] ld_type; // @[Datapath.scala 43:21]
  reg [1:0] wb_sel; // @[Datapath.scala 44:21]
  reg  wb_en; // @[Datapath.scala 45:21]
  reg [2:0] csr_cmd; // @[Datapath.scala 46:21]
  reg  illegal; // @[Datapath.scala 47:21]
  reg  pc_check; // @[Datapath.scala 48:21]
  reg  started; // @[Datapath.scala 51:24]
  wire  _T_1 = ~io_icache_resp_valid; // @[Datapath.scala 52:15]
  wire  _T_2 = ~io_dcache_resp_valid; // @[Datapath.scala 52:40]
  wire  stall = _T_1 | _T_2; // @[Datapath.scala 52:37]
  wire [31:0] _T_4 = 32'h200 - 32'h4; // @[Datapath.scala 53:47]
  reg [32:0] pc; // @[Datapath.scala 53:21]
  wire  _T_5 = io_ctrl_pc_sel == 2'h3; // @[Datapath.scala 55:33]
  wire  _T_6 = io_ctrl_pc_sel == 2'h1; // @[Datapath.scala 56:33]
  wire  _T_7 = _T_6 | brCond_io_taken; // @[Datapath.scala 56:44]
  wire [31:0] _T_8 = {{1'd0}, alu_io_sum[31:1]}; // @[Datapath.scala 56:75]
  wire [32:0] _T_9 = {_T_8, 1'h0}; // @[Datapath.scala 56:82]
  wire  _T_10 = io_ctrl_pc_sel == 2'h2; // @[Datapath.scala 57:33]
  wire [32:0] _T_12 = pc + 33'h4; // @[Datapath.scala 57:50]
  wire [32:0] _T_13 = _T_10 ? pc : _T_12; // @[Datapath.scala 57:17]
  wire [32:0] _T_14 = _T_7 ? _T_9 : _T_13; // @[Datapath.scala 56:17]
  wire [32:0] _T_15 = _T_5 ? {{1'd0}, csr_io_epc} : _T_14; // @[Datapath.scala 55:17]
  wire [32:0] _T_16 = csr_io_expt ? {{1'd0}, csr_io_evec} : _T_15; // @[Datapath.scala 54:32]
  wire [32:0] npc = stall ? pc : _T_16; // @[Datapath.scala 54:17]
  wire  _T_17 = started | io_ctrl_inst_kill; // @[Datapath.scala 58:26]
  wire  _T_18 = _T_17 | brCond_io_taken; // @[Datapath.scala 58:47]
  wire  _T_19 = _T_18 | csr_io_expt; // @[Datapath.scala 58:66]
  wire  _T_20 = ~stall; // @[Datapath.scala 63:30]
  wire [4:0] rs1_addr = fe_inst[19:15]; // @[Datapath.scala 78:25]
  wire [4:0] rs2_addr = fe_inst[24:20]; // @[Datapath.scala 79:25]
  wire [4:0] wb_rd_addr = ew_inst[11:7]; // @[Datapath.scala 88:27]
  wire  _T_22 = |rs1_addr; // @[Datapath.scala 89:37]
  wire  _T_23 = wb_en & _T_22; // @[Datapath.scala 89:25]
  wire  _T_24 = rs1_addr == wb_rd_addr; // @[Datapath.scala 89:54]
  wire  rs1hazard = _T_23 & _T_24; // @[Datapath.scala 89:41]
  wire  _T_25 = |rs2_addr; // @[Datapath.scala 90:37]
  wire  _T_26 = wb_en & _T_25; // @[Datapath.scala 90:25]
  wire  _T_27 = rs2_addr == wb_rd_addr; // @[Datapath.scala 90:54]
  wire  rs2hazard = _T_26 & _T_27; // @[Datapath.scala 90:41]
  wire  _T_28 = wb_sel == 2'h0; // @[Datapath.scala 91:24]
  wire  _T_29 = _T_28 & rs1hazard; // @[Datapath.scala 91:35]
  wire [31:0] rs1 = _T_29 ? ew_alu : regFile_io_rdata1; // @[Datapath.scala 91:16]
  wire  _T_31 = _T_28 & rs2hazard; // @[Datapath.scala 92:35]
  wire [31:0] rs2 = _T_31 ? ew_alu : regFile_io_rdata2; // @[Datapath.scala 92:16]
  wire [32:0] _T_33 = io_ctrl_A_sel ? {{1'd0}, rs1} : fe_pc; // @[Datapath.scala 95:18]
  wire [31:0] _T_36 = stall ? ew_alu : alu_io_sum; // @[Datapath.scala 105:20]
  wire [31:0] _T_37 = {{2'd0}, _T_36[31:2]}; // @[Datapath.scala 105:48]
  wire [33:0] _GEN_26 = {_T_37, 2'h0}; // @[Datapath.scala 105:55]
  wire [34:0] daddr = {{1'd0}, _GEN_26}; // @[Datapath.scala 105:55]
  wire [4:0] _GEN_27 = {alu_io_sum[1], 4'h0}; // @[Datapath.scala 106:32]
  wire [7:0] _T_39 = {{3'd0}, _GEN_27}; // @[Datapath.scala 106:32]
  wire [3:0] _T_41 = {alu_io_sum[0], 3'h0}; // @[Datapath.scala 106:64]
  wire [7:0] _GEN_28 = {{4'd0}, _T_41}; // @[Datapath.scala 106:47]
  wire [7:0] woffset = _T_39 | _GEN_28; // @[Datapath.scala 106:47]
  wire  _T_43 = |io_ctrl_st_type; // @[Datapath.scala 107:57]
  wire  _T_44 = |io_ctrl_ld_type; // @[Datapath.scala 107:80]
  wire  _T_45 = _T_43 | _T_44; // @[Datapath.scala 107:61]
  wire [286:0] _GEN_29 = {{255'd0}, rs2}; // @[Datapath.scala 109:34]
  wire [286:0] _T_47 = _GEN_29 << woffset; // @[Datapath.scala 109:34]
  wire [1:0] _T_48 = stall ? st_type : io_ctrl_st_type; // @[Datapath.scala 110:43]
  wire [4:0] _T_50 = 5'h3 << alu_io_sum[1:0]; // @[Datapath.scala 113:23]
  wire [3:0] _T_52 = 4'h1 << alu_io_sum[1:0]; // @[Datapath.scala 114:23]
  wire  _T_53 = 2'h1 == _T_48; // @[Mux.scala 80:60]
  wire [3:0] _T_54 = _T_53 ? 4'hf : 4'h0; // @[Mux.scala 80:57]
  wire  _T_55 = 2'h2 == _T_48; // @[Mux.scala 80:60]
  wire [4:0] _T_56 = _T_55 ? _T_50 : {{1'd0}, _T_54}; // @[Mux.scala 80:57]
  wire  _T_57 = 2'h3 == _T_48; // @[Mux.scala 80:60]
  wire [4:0] _T_58 = _T_57 ? {{1'd0}, _T_52} : _T_56; // @[Mux.scala 80:57]
  wire  _T_61 = _T_20 & csr_io_expt; // @[Datapath.scala 117:31]
  wire  _T_62 = reset | _T_61; // @[Datapath.scala 117:21]
  wire  _T_64 = ~csr_io_expt; // @[Datapath.scala 124:24]
  wire  _T_65 = _T_20 & _T_64; // @[Datapath.scala 124:21]
  wire  _T_66 = io_ctrl_imm_sel == 3'h6; // @[Datapath.scala 128:38]
  wire [4:0] _GEN_30 = {ew_alu[1], 4'h0}; // @[Datapath.scala 139:28]
  wire [7:0] _T_70 = {{3'd0}, _GEN_30}; // @[Datapath.scala 139:28]
  wire [3:0] _T_72 = {ew_alu[0], 3'h0}; // @[Datapath.scala 139:56]
  wire [7:0] _GEN_31 = {{4'd0}, _T_72}; // @[Datapath.scala 139:43]
  wire [7:0] loffset = _T_70 | _GEN_31; // @[Datapath.scala 139:43]
  wire [31:0] lshift = io_dcache_resp_bits_data >> loffset; // @[Datapath.scala 140:42]
  wire [32:0] _T_73 = {1'b0,$signed(io_dcache_resp_bits_data)}; // @[Datapath.scala 141:61]
  wire [15:0] _T_75 = lshift[15:0]; // @[Datapath.scala 142:29]
  wire [7:0] _T_77 = lshift[7:0]; // @[Datapath.scala 142:60]
  wire [16:0] _T_79 = {1'b0,$signed(lshift[15:0])}; // @[Datapath.scala 143:29]
  wire [8:0] _T_81 = {1'b0,$signed(lshift[7:0])}; // @[Datapath.scala 143:60]
  wire  _T_82 = 3'h2 == ld_type; // @[Mux.scala 80:60]
  wire [32:0] _T_83 = _T_82 ? $signed({{17{_T_75[15]}},_T_75}) : $signed(_T_73); // @[Mux.scala 80:57]
  wire  _T_84 = 3'h3 == ld_type; // @[Mux.scala 80:60]
  wire [32:0] _T_85 = _T_84 ? $signed({{25{_T_77[7]}},_T_77}) : $signed(_T_83); // @[Mux.scala 80:57]
  wire  _T_86 = 3'h4 == ld_type; // @[Mux.scala 80:60]
  wire [32:0] _T_87 = _T_86 ? $signed({{16{_T_79[16]}},_T_79}) : $signed(_T_85); // @[Mux.scala 80:57]
  wire  _T_88 = 3'h5 == ld_type; // @[Mux.scala 80:60]
  wire [32:0] load = _T_88 ? $signed({{24{_T_81[8]}},_T_81}) : $signed(_T_87); // @[Mux.scala 80:57]
  wire [32:0] _T_89 = {1'b0,$signed(ew_alu)}; // @[Datapath.scala 159:43]
  wire [32:0] _T_91 = ew_pc + 33'h4; // @[Datapath.scala 161:22]
  wire [33:0] _T_92 = {1'b0,$signed(_T_91)}; // @[Datapath.scala 161:29]
  wire [32:0] _T_93 = {1'b0,$signed(csr_io_out)}; // @[Datapath.scala 162:26]
  wire  _T_94 = 2'h1 == wb_sel; // @[Mux.scala 80:60]
  wire [32:0] _T_95 = _T_94 ? $signed(load) : $signed(_T_89); // @[Mux.scala 80:57]
  wire  _T_96 = 2'h2 == wb_sel; // @[Mux.scala 80:60]
  wire [33:0] _T_97 = _T_96 ? $signed(_T_92) : $signed({{1{_T_95[32]}},_T_95}); // @[Mux.scala 80:57]
  wire  _T_98 = 2'h3 == wb_sel; // @[Mux.scala 80:60]
  wire [33:0] regWrite = _T_98 ? $signed({{1{_T_93[32]}},_T_93}) : $signed(_T_97); // @[Datapath.scala 162:34]
  wire  _T_101 = wb_en & _T_20; // @[Datapath.scala 164:29]
  CSR csr ( // @[Datapath.scala 23:23]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_stall(csr_io_stall),
    .io_cmd(csr_io_cmd),
    .io_in(csr_io_in),
    .io_out(csr_io_out),
    .io_pc(csr_io_pc),
    .io_addr(csr_io_addr),
    .io_inst(csr_io_inst),
    .io_illegal(csr_io_illegal),
    .io_st_type(csr_io_st_type),
    .io_ld_type(csr_io_ld_type),
    .io_pc_check(csr_io_pc_check),
    .io_expt(csr_io_expt),
    .io_evec(csr_io_evec),
    .io_epc(csr_io_epc),
    .io_host_fromhost_valid(csr_io_host_fromhost_valid),
    .io_host_fromhost_bits(csr_io_host_fromhost_bits),
    .io_host_tohost(csr_io_host_tohost)
  );
  RegFile regFile ( // @[Datapath.scala 24:23]
    .clock(regFile_clock),
    .io_raddr1(regFile_io_raddr1),
    .io_raddr2(regFile_io_raddr2),
    .io_rdata1(regFile_io_rdata1),
    .io_rdata2(regFile_io_rdata2),
    .io_wen(regFile_io_wen),
    .io_waddr(regFile_io_waddr),
    .io_wdata(regFile_io_wdata)
  );
  ALUArea alu ( // @[Config.scala 13:50]
    .io_A(alu_io_A),
    .io_B(alu_io_B),
    .io_alu_op(alu_io_alu_op),
    .io_out(alu_io_out),
    .io_sum(alu_io_sum)
  );
  ImmGenWire immGen ( // @[Config.scala 14:50]
    .io_inst(immGen_io_inst),
    .io_sel(immGen_io_sel),
    .io_out(immGen_io_out)
  );
  BrCondArea brCond ( // @[Config.scala 15:50]
    .io_rs1(brCond_io_rs1),
    .io_rs2(brCond_io_rs2),
    .io_br_type(brCond_io_br_type),
    .io_taken(brCond_io_taken)
  );
  assign io_host_tohost = csr_io_host_tohost; // @[Datapath.scala 156:11]
  assign io_icache_req_valid = ~stall; // @[Datapath.scala 63:27]
  assign io_icache_req_bits_addr = npc[31:0]; // @[Datapath.scala 60:27]
  assign io_dcache_abort = csr_io_expt; // @[Datapath.scala 169:19]
  assign io_dcache_req_valid = _T_20 & _T_45; // @[Datapath.scala 107:27]
  assign io_dcache_req_bits_addr = daddr[31:0]; // @[Datapath.scala 108:27]
  assign io_dcache_req_bits_data = _T_47[31:0]; // @[Datapath.scala 109:27]
  assign io_dcache_req_bits_mask = _T_58[3:0]; // @[Datapath.scala 110:27]
  assign io_ctrl_inst = fe_inst; // @[Datapath.scala 74:17]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_stall = _T_1 | _T_2; // @[Datapath.scala 146:19]
  assign csr_io_cmd = csr_cmd; // @[Datapath.scala 148:19]
  assign csr_io_in = csr_in; // @[Datapath.scala 147:19]
  assign csr_io_pc = ew_pc[31:0]; // @[Datapath.scala 150:19]
  assign csr_io_addr = ew_alu; // @[Datapath.scala 151:19]
  assign csr_io_inst = ew_inst; // @[Datapath.scala 149:19]
  assign csr_io_illegal = illegal; // @[Datapath.scala 152:19]
  assign csr_io_st_type = st_type; // @[Datapath.scala 155:19]
  assign csr_io_ld_type = ld_type; // @[Datapath.scala 154:19]
  assign csr_io_pc_check = pc_check; // @[Datapath.scala 153:19]
  assign csr_io_host_fromhost_valid = io_host_fromhost_valid; // @[Datapath.scala 156:11]
  assign csr_io_host_fromhost_bits = io_host_fromhost_bits; // @[Datapath.scala 156:11]
  assign regFile_clock = clock;
  assign regFile_io_raddr1 = fe_inst[19:15]; // @[Datapath.scala 80:21]
  assign regFile_io_raddr2 = fe_inst[24:20]; // @[Datapath.scala 81:21]
  assign regFile_io_wen = _T_101 & _T_64; // @[Datapath.scala 164:20]
  assign regFile_io_waddr = ew_inst[11:7]; // @[Datapath.scala 165:20]
  assign regFile_io_wdata = regWrite[31:0]; // @[Datapath.scala 166:20]
  assign alu_io_A = _T_33[31:0]; // @[Datapath.scala 95:12]
  assign alu_io_B = io_ctrl_B_sel ? rs2 : immGen_io_out; // @[Datapath.scala 96:12]
  assign alu_io_alu_op = io_ctrl_alu_op; // @[Datapath.scala 97:17]
  assign immGen_io_inst = fe_inst; // @[Datapath.scala 84:18]
  assign immGen_io_sel = io_ctrl_imm_sel; // @[Datapath.scala 85:18]
  assign brCond_io_rs1 = _T_29 ? ew_alu : regFile_io_rdata1; // @[Datapath.scala 100:17]
  assign brCond_io_rs2 = _T_31 ? ew_alu : regFile_io_rdata2; // @[Datapath.scala 101:17]
  assign brCond_io_br_type = io_ctrl_br_type; // @[Datapath.scala 102:21]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  fe_inst = _RAND_0[31:0];
  _RAND_1 = {2{`RANDOM}};
  fe_pc = _RAND_1[32:0];
  _RAND_2 = {1{`RANDOM}};
  ew_inst = _RAND_2[31:0];
  _RAND_3 = {2{`RANDOM}};
  ew_pc = _RAND_3[32:0];
  _RAND_4 = {1{`RANDOM}};
  ew_alu = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  csr_in = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  st_type = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  ld_type = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  wb_sel = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  wb_en = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  csr_cmd = _RAND_10[2:0];
  _RAND_11 = {1{`RANDOM}};
  illegal = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  pc_check = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  started = _RAND_13[0:0];
  _RAND_14 = {2{`RANDOM}};
  pc = _RAND_14[32:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      fe_inst <= 32'h13;
    end else if (_T_20) begin
      if (_T_19) begin
        fe_inst <= 32'h13;
      end else begin
        fe_inst <= io_icache_resp_bits_data;
      end
    end
    if (_T_20) begin
      fe_pc <= pc;
    end
    if (reset) begin
      ew_inst <= 32'h13;
    end else if (!(_T_62)) begin
      if (_T_65) begin
        ew_inst <= fe_inst;
      end
    end
    if (!(_T_62)) begin
      if (_T_65) begin
        ew_pc <= fe_pc;
      end
    end
    if (!(_T_62)) begin
      if (_T_65) begin
        ew_alu <= alu_io_out;
      end
    end
    if (!(_T_62)) begin
      if (_T_65) begin
        if (_T_66) begin
          csr_in <= immGen_io_out;
        end else if (_T_29) begin
          csr_in <= ew_alu;
        end else begin
          csr_in <= regFile_io_rdata1;
        end
      end
    end
    if (_T_62) begin
      st_type <= 2'h0;
    end else if (_T_65) begin
      st_type <= io_ctrl_st_type;
    end
    if (_T_62) begin
      ld_type <= 3'h0;
    end else if (_T_65) begin
      ld_type <= io_ctrl_ld_type;
    end
    if (!(_T_62)) begin
      if (_T_65) begin
        wb_sel <= io_ctrl_wb_sel;
      end
    end
    if (_T_62) begin
      wb_en <= 1'h0;
    end else if (_T_65) begin
      wb_en <= io_ctrl_wb_en;
    end
    if (_T_62) begin
      csr_cmd <= 3'h0;
    end else if (_T_65) begin
      csr_cmd <= io_ctrl_csr_cmd;
    end
    if (_T_62) begin
      illegal <= 1'h0;
    end else if (_T_65) begin
      illegal <= io_ctrl_illegal;
    end
    if (_T_62) begin
      pc_check <= 1'h0;
    end else if (_T_65) begin
      pc_check <= _T_6;
    end
    started <= reset;
    if (reset) begin
      pc <= {{1'd0}, _T_4};
    end else if (!(stall)) begin
      if (csr_io_expt) begin
        pc <= {{1'd0}, csr_io_evec};
      end else if (_T_5) begin
        pc <= {{1'd0}, csr_io_epc};
      end else if (_T_7) begin
        pc <= _T_9;
      end else if (!(_T_10)) begin
        pc <= _T_12;
      end
    end
  end
endmodule
module Control(
  input  [31:0] io_inst,
  output [1:0]  io_pc_sel,
  output        io_inst_kill,
  output        io_A_sel,
  output        io_B_sel,
  output [2:0]  io_imm_sel,
  output [3:0]  io_alu_op,
  output [2:0]  io_br_type,
  output [1:0]  io_st_type,
  output [2:0]  io_ld_type,
  output [1:0]  io_wb_sel,
  output        io_wb_en,
  output [2:0]  io_csr_cmd,
  output        io_illegal
);
  wire [31:0] _T = io_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _T_1 = 32'h37 == _T; // @[Lookup.scala 31:38]
  wire  _T_3 = 32'h17 == _T; // @[Lookup.scala 31:38]
  wire  _T_5 = 32'h6f == _T; // @[Lookup.scala 31:38]
  wire [31:0] _T_6 = io_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _T_7 = 32'h67 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_9 = 32'h63 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_11 = 32'h1063 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_13 = 32'h4063 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_15 = 32'h5063 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_17 = 32'h6063 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_19 = 32'h7063 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_21 = 32'h3 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_23 = 32'h1003 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_25 = 32'h2003 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_27 = 32'h4003 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_29 = 32'h5003 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_31 = 32'h23 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_33 = 32'h1023 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_35 = 32'h2023 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_37 = 32'h13 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_39 = 32'h2013 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_41 = 32'h3013 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_43 = 32'h4013 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_45 = 32'h6013 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_47 = 32'h7013 == _T_6; // @[Lookup.scala 31:38]
  wire [31:0] _T_48 = io_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _T_49 = 32'h1013 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_51 = 32'h5013 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_53 = 32'h40005013 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_55 = 32'h33 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_57 = 32'h40000033 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_59 = 32'h1033 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_61 = 32'h2033 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_63 = 32'h3033 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_65 = 32'h4033 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_67 = 32'h5033 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_69 = 32'h40005033 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_71 = 32'h6033 == _T_48; // @[Lookup.scala 31:38]
  wire  _T_73 = 32'h7033 == _T_48; // @[Lookup.scala 31:38]
  wire [31:0] _T_74 = io_inst & 32'hf00fffff; // @[Lookup.scala 31:38]
  wire  _T_75 = 32'hf == _T_74; // @[Lookup.scala 31:38]
  wire  _T_77 = 32'h100f == io_inst; // @[Lookup.scala 31:38]
  wire  _T_79 = 32'h1073 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_81 = 32'h2073 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_83 = 32'h3073 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_85 = 32'h5073 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_87 = 32'h6073 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_89 = 32'h7073 == _T_6; // @[Lookup.scala 31:38]
  wire  _T_91 = 32'h73 == io_inst; // @[Lookup.scala 31:38]
  wire  _T_93 = 32'h100073 == io_inst; // @[Lookup.scala 31:38]
  wire  _T_95 = 32'h10000073 == io_inst; // @[Lookup.scala 31:38]
  wire  _T_97 = 32'h10200073 == io_inst; // @[Lookup.scala 31:38]
  wire [1:0] _T_99 = _T_95 ? 2'h3 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _T_100 = _T_93 ? 2'h0 : _T_99; // @[Lookup.scala 33:37]
  wire [1:0] _T_101 = _T_91 ? 2'h0 : _T_100; // @[Lookup.scala 33:37]
  wire [1:0] _T_102 = _T_89 ? 2'h2 : _T_101; // @[Lookup.scala 33:37]
  wire [1:0] _T_103 = _T_87 ? 2'h2 : _T_102; // @[Lookup.scala 33:37]
  wire [1:0] _T_104 = _T_85 ? 2'h2 : _T_103; // @[Lookup.scala 33:37]
  wire [1:0] _T_105 = _T_83 ? 2'h2 : _T_104; // @[Lookup.scala 33:37]
  wire [1:0] _T_106 = _T_81 ? 2'h2 : _T_105; // @[Lookup.scala 33:37]
  wire [1:0] _T_107 = _T_79 ? 2'h2 : _T_106; // @[Lookup.scala 33:37]
  wire [1:0] _T_108 = _T_77 ? 2'h2 : _T_107; // @[Lookup.scala 33:37]
  wire [1:0] _T_109 = _T_75 ? 2'h0 : _T_108; // @[Lookup.scala 33:37]
  wire [1:0] _T_110 = _T_73 ? 2'h0 : _T_109; // @[Lookup.scala 33:37]
  wire [1:0] _T_111 = _T_71 ? 2'h0 : _T_110; // @[Lookup.scala 33:37]
  wire [1:0] _T_112 = _T_69 ? 2'h0 : _T_111; // @[Lookup.scala 33:37]
  wire [1:0] _T_113 = _T_67 ? 2'h0 : _T_112; // @[Lookup.scala 33:37]
  wire [1:0] _T_114 = _T_65 ? 2'h0 : _T_113; // @[Lookup.scala 33:37]
  wire [1:0] _T_115 = _T_63 ? 2'h0 : _T_114; // @[Lookup.scala 33:37]
  wire [1:0] _T_116 = _T_61 ? 2'h0 : _T_115; // @[Lookup.scala 33:37]
  wire [1:0] _T_117 = _T_59 ? 2'h0 : _T_116; // @[Lookup.scala 33:37]
  wire [1:0] _T_118 = _T_57 ? 2'h0 : _T_117; // @[Lookup.scala 33:37]
  wire [1:0] _T_119 = _T_55 ? 2'h0 : _T_118; // @[Lookup.scala 33:37]
  wire [1:0] _T_120 = _T_53 ? 2'h0 : _T_119; // @[Lookup.scala 33:37]
  wire [1:0] _T_121 = _T_51 ? 2'h0 : _T_120; // @[Lookup.scala 33:37]
  wire [1:0] _T_122 = _T_49 ? 2'h0 : _T_121; // @[Lookup.scala 33:37]
  wire [1:0] _T_123 = _T_47 ? 2'h0 : _T_122; // @[Lookup.scala 33:37]
  wire [1:0] _T_124 = _T_45 ? 2'h0 : _T_123; // @[Lookup.scala 33:37]
  wire [1:0] _T_125 = _T_43 ? 2'h0 : _T_124; // @[Lookup.scala 33:37]
  wire [1:0] _T_126 = _T_41 ? 2'h0 : _T_125; // @[Lookup.scala 33:37]
  wire [1:0] _T_127 = _T_39 ? 2'h0 : _T_126; // @[Lookup.scala 33:37]
  wire [1:0] _T_128 = _T_37 ? 2'h0 : _T_127; // @[Lookup.scala 33:37]
  wire [1:0] _T_129 = _T_35 ? 2'h0 : _T_128; // @[Lookup.scala 33:37]
  wire [1:0] _T_130 = _T_33 ? 2'h0 : _T_129; // @[Lookup.scala 33:37]
  wire [1:0] _T_131 = _T_31 ? 2'h0 : _T_130; // @[Lookup.scala 33:37]
  wire [1:0] _T_132 = _T_29 ? 2'h2 : _T_131; // @[Lookup.scala 33:37]
  wire [1:0] _T_133 = _T_27 ? 2'h2 : _T_132; // @[Lookup.scala 33:37]
  wire [1:0] _T_134 = _T_25 ? 2'h2 : _T_133; // @[Lookup.scala 33:37]
  wire [1:0] _T_135 = _T_23 ? 2'h2 : _T_134; // @[Lookup.scala 33:37]
  wire [1:0] _T_136 = _T_21 ? 2'h2 : _T_135; // @[Lookup.scala 33:37]
  wire [1:0] _T_137 = _T_19 ? 2'h0 : _T_136; // @[Lookup.scala 33:37]
  wire [1:0] _T_138 = _T_17 ? 2'h0 : _T_137; // @[Lookup.scala 33:37]
  wire [1:0] _T_139 = _T_15 ? 2'h0 : _T_138; // @[Lookup.scala 33:37]
  wire [1:0] _T_140 = _T_13 ? 2'h0 : _T_139; // @[Lookup.scala 33:37]
  wire [1:0] _T_141 = _T_11 ? 2'h0 : _T_140; // @[Lookup.scala 33:37]
  wire [1:0] _T_142 = _T_9 ? 2'h0 : _T_141; // @[Lookup.scala 33:37]
  wire [1:0] _T_143 = _T_7 ? 2'h1 : _T_142; // @[Lookup.scala 33:37]
  wire [1:0] _T_144 = _T_5 ? 2'h1 : _T_143; // @[Lookup.scala 33:37]
  wire [1:0] _T_145 = _T_3 ? 2'h0 : _T_144; // @[Lookup.scala 33:37]
  wire  _T_154 = _T_81 | _T_83; // @[Lookup.scala 33:37]
  wire  _T_155 = _T_79 | _T_154; // @[Lookup.scala 33:37]
  wire  _T_156 = _T_77 ? 1'h0 : _T_155; // @[Lookup.scala 33:37]
  wire  _T_157 = _T_75 ? 1'h0 : _T_156; // @[Lookup.scala 33:37]
  wire  _T_158 = _T_73 | _T_157; // @[Lookup.scala 33:37]
  wire  _T_159 = _T_71 | _T_158; // @[Lookup.scala 33:37]
  wire  _T_160 = _T_69 | _T_159; // @[Lookup.scala 33:37]
  wire  _T_161 = _T_67 | _T_160; // @[Lookup.scala 33:37]
  wire  _T_162 = _T_65 | _T_161; // @[Lookup.scala 33:37]
  wire  _T_163 = _T_63 | _T_162; // @[Lookup.scala 33:37]
  wire  _T_164 = _T_61 | _T_163; // @[Lookup.scala 33:37]
  wire  _T_165 = _T_59 | _T_164; // @[Lookup.scala 33:37]
  wire  _T_166 = _T_57 | _T_165; // @[Lookup.scala 33:37]
  wire  _T_167 = _T_55 | _T_166; // @[Lookup.scala 33:37]
  wire  _T_168 = _T_53 | _T_167; // @[Lookup.scala 33:37]
  wire  _T_169 = _T_51 | _T_168; // @[Lookup.scala 33:37]
  wire  _T_170 = _T_49 | _T_169; // @[Lookup.scala 33:37]
  wire  _T_171 = _T_47 | _T_170; // @[Lookup.scala 33:37]
  wire  _T_172 = _T_45 | _T_171; // @[Lookup.scala 33:37]
  wire  _T_173 = _T_43 | _T_172; // @[Lookup.scala 33:37]
  wire  _T_174 = _T_41 | _T_173; // @[Lookup.scala 33:37]
  wire  _T_175 = _T_39 | _T_174; // @[Lookup.scala 33:37]
  wire  _T_176 = _T_37 | _T_175; // @[Lookup.scala 33:37]
  wire  _T_177 = _T_35 | _T_176; // @[Lookup.scala 33:37]
  wire  _T_178 = _T_33 | _T_177; // @[Lookup.scala 33:37]
  wire  _T_179 = _T_31 | _T_178; // @[Lookup.scala 33:37]
  wire  _T_180 = _T_29 | _T_179; // @[Lookup.scala 33:37]
  wire  _T_181 = _T_27 | _T_180; // @[Lookup.scala 33:37]
  wire  _T_182 = _T_25 | _T_181; // @[Lookup.scala 33:37]
  wire  _T_183 = _T_23 | _T_182; // @[Lookup.scala 33:37]
  wire  _T_184 = _T_21 | _T_183; // @[Lookup.scala 33:37]
  wire  _T_185 = _T_19 ? 1'h0 : _T_184; // @[Lookup.scala 33:37]
  wire  _T_186 = _T_17 ? 1'h0 : _T_185; // @[Lookup.scala 33:37]
  wire  _T_187 = _T_15 ? 1'h0 : _T_186; // @[Lookup.scala 33:37]
  wire  _T_188 = _T_13 ? 1'h0 : _T_187; // @[Lookup.scala 33:37]
  wire  _T_189 = _T_11 ? 1'h0 : _T_188; // @[Lookup.scala 33:37]
  wire  _T_190 = _T_9 ? 1'h0 : _T_189; // @[Lookup.scala 33:37]
  wire  _T_191 = _T_7 | _T_190; // @[Lookup.scala 33:37]
  wire  _T_192 = _T_5 ? 1'h0 : _T_191; // @[Lookup.scala 33:37]
  wire  _T_193 = _T_3 ? 1'h0 : _T_192; // @[Lookup.scala 33:37]
  wire  _T_207 = _T_71 | _T_73; // @[Lookup.scala 33:37]
  wire  _T_208 = _T_69 | _T_207; // @[Lookup.scala 33:37]
  wire  _T_209 = _T_67 | _T_208; // @[Lookup.scala 33:37]
  wire  _T_210 = _T_65 | _T_209; // @[Lookup.scala 33:37]
  wire  _T_211 = _T_63 | _T_210; // @[Lookup.scala 33:37]
  wire  _T_212 = _T_61 | _T_211; // @[Lookup.scala 33:37]
  wire  _T_213 = _T_59 | _T_212; // @[Lookup.scala 33:37]
  wire  _T_214 = _T_57 | _T_213; // @[Lookup.scala 33:37]
  wire  _T_215 = _T_55 | _T_214; // @[Lookup.scala 33:37]
  wire  _T_216 = _T_53 ? 1'h0 : _T_215; // @[Lookup.scala 33:37]
  wire  _T_217 = _T_51 ? 1'h0 : _T_216; // @[Lookup.scala 33:37]
  wire  _T_218 = _T_49 ? 1'h0 : _T_217; // @[Lookup.scala 33:37]
  wire  _T_219 = _T_47 ? 1'h0 : _T_218; // @[Lookup.scala 33:37]
  wire  _T_220 = _T_45 ? 1'h0 : _T_219; // @[Lookup.scala 33:37]
  wire  _T_221 = _T_43 ? 1'h0 : _T_220; // @[Lookup.scala 33:37]
  wire  _T_222 = _T_41 ? 1'h0 : _T_221; // @[Lookup.scala 33:37]
  wire  _T_223 = _T_39 ? 1'h0 : _T_222; // @[Lookup.scala 33:37]
  wire  _T_224 = _T_37 ? 1'h0 : _T_223; // @[Lookup.scala 33:37]
  wire  _T_225 = _T_35 ? 1'h0 : _T_224; // @[Lookup.scala 33:37]
  wire  _T_226 = _T_33 ? 1'h0 : _T_225; // @[Lookup.scala 33:37]
  wire  _T_227 = _T_31 ? 1'h0 : _T_226; // @[Lookup.scala 33:37]
  wire  _T_228 = _T_29 ? 1'h0 : _T_227; // @[Lookup.scala 33:37]
  wire  _T_229 = _T_27 ? 1'h0 : _T_228; // @[Lookup.scala 33:37]
  wire  _T_230 = _T_25 ? 1'h0 : _T_229; // @[Lookup.scala 33:37]
  wire  _T_231 = _T_23 ? 1'h0 : _T_230; // @[Lookup.scala 33:37]
  wire  _T_232 = _T_21 ? 1'h0 : _T_231; // @[Lookup.scala 33:37]
  wire  _T_233 = _T_19 ? 1'h0 : _T_232; // @[Lookup.scala 33:37]
  wire  _T_234 = _T_17 ? 1'h0 : _T_233; // @[Lookup.scala 33:37]
  wire  _T_235 = _T_15 ? 1'h0 : _T_234; // @[Lookup.scala 33:37]
  wire  _T_236 = _T_13 ? 1'h0 : _T_235; // @[Lookup.scala 33:37]
  wire  _T_237 = _T_11 ? 1'h0 : _T_236; // @[Lookup.scala 33:37]
  wire  _T_238 = _T_9 ? 1'h0 : _T_237; // @[Lookup.scala 33:37]
  wire  _T_239 = _T_7 ? 1'h0 : _T_238; // @[Lookup.scala 33:37]
  wire  _T_240 = _T_5 ? 1'h0 : _T_239; // @[Lookup.scala 33:37]
  wire  _T_241 = _T_3 ? 1'h0 : _T_240; // @[Lookup.scala 33:37]
  wire [2:0] _T_246 = _T_89 ? 3'h6 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _T_247 = _T_87 ? 3'h6 : _T_246; // @[Lookup.scala 33:37]
  wire [2:0] _T_248 = _T_85 ? 3'h6 : _T_247; // @[Lookup.scala 33:37]
  wire [2:0] _T_249 = _T_83 ? 3'h0 : _T_248; // @[Lookup.scala 33:37]
  wire [2:0] _T_250 = _T_81 ? 3'h0 : _T_249; // @[Lookup.scala 33:37]
  wire [2:0] _T_251 = _T_79 ? 3'h0 : _T_250; // @[Lookup.scala 33:37]
  wire [2:0] _T_252 = _T_77 ? 3'h0 : _T_251; // @[Lookup.scala 33:37]
  wire [2:0] _T_253 = _T_75 ? 3'h0 : _T_252; // @[Lookup.scala 33:37]
  wire [2:0] _T_254 = _T_73 ? 3'h0 : _T_253; // @[Lookup.scala 33:37]
  wire [2:0] _T_255 = _T_71 ? 3'h0 : _T_254; // @[Lookup.scala 33:37]
  wire [2:0] _T_256 = _T_69 ? 3'h0 : _T_255; // @[Lookup.scala 33:37]
  wire [2:0] _T_257 = _T_67 ? 3'h0 : _T_256; // @[Lookup.scala 33:37]
  wire [2:0] _T_258 = _T_65 ? 3'h0 : _T_257; // @[Lookup.scala 33:37]
  wire [2:0] _T_259 = _T_63 ? 3'h0 : _T_258; // @[Lookup.scala 33:37]
  wire [2:0] _T_260 = _T_61 ? 3'h0 : _T_259; // @[Lookup.scala 33:37]
  wire [2:0] _T_261 = _T_59 ? 3'h0 : _T_260; // @[Lookup.scala 33:37]
  wire [2:0] _T_262 = _T_57 ? 3'h0 : _T_261; // @[Lookup.scala 33:37]
  wire [2:0] _T_263 = _T_55 ? 3'h0 : _T_262; // @[Lookup.scala 33:37]
  wire [2:0] _T_264 = _T_53 ? 3'h1 : _T_263; // @[Lookup.scala 33:37]
  wire [2:0] _T_265 = _T_51 ? 3'h1 : _T_264; // @[Lookup.scala 33:37]
  wire [2:0] _T_266 = _T_49 ? 3'h1 : _T_265; // @[Lookup.scala 33:37]
  wire [2:0] _T_267 = _T_47 ? 3'h1 : _T_266; // @[Lookup.scala 33:37]
  wire [2:0] _T_268 = _T_45 ? 3'h1 : _T_267; // @[Lookup.scala 33:37]
  wire [2:0] _T_269 = _T_43 ? 3'h1 : _T_268; // @[Lookup.scala 33:37]
  wire [2:0] _T_270 = _T_41 ? 3'h1 : _T_269; // @[Lookup.scala 33:37]
  wire [2:0] _T_271 = _T_39 ? 3'h1 : _T_270; // @[Lookup.scala 33:37]
  wire [2:0] _T_272 = _T_37 ? 3'h1 : _T_271; // @[Lookup.scala 33:37]
  wire [2:0] _T_273 = _T_35 ? 3'h2 : _T_272; // @[Lookup.scala 33:37]
  wire [2:0] _T_274 = _T_33 ? 3'h2 : _T_273; // @[Lookup.scala 33:37]
  wire [2:0] _T_275 = _T_31 ? 3'h2 : _T_274; // @[Lookup.scala 33:37]
  wire [2:0] _T_276 = _T_29 ? 3'h1 : _T_275; // @[Lookup.scala 33:37]
  wire [2:0] _T_277 = _T_27 ? 3'h1 : _T_276; // @[Lookup.scala 33:37]
  wire [2:0] _T_278 = _T_25 ? 3'h1 : _T_277; // @[Lookup.scala 33:37]
  wire [2:0] _T_279 = _T_23 ? 3'h1 : _T_278; // @[Lookup.scala 33:37]
  wire [2:0] _T_280 = _T_21 ? 3'h1 : _T_279; // @[Lookup.scala 33:37]
  wire [2:0] _T_281 = _T_19 ? 3'h5 : _T_280; // @[Lookup.scala 33:37]
  wire [2:0] _T_282 = _T_17 ? 3'h5 : _T_281; // @[Lookup.scala 33:37]
  wire [2:0] _T_283 = _T_15 ? 3'h5 : _T_282; // @[Lookup.scala 33:37]
  wire [2:0] _T_284 = _T_13 ? 3'h5 : _T_283; // @[Lookup.scala 33:37]
  wire [2:0] _T_285 = _T_11 ? 3'h5 : _T_284; // @[Lookup.scala 33:37]
  wire [2:0] _T_286 = _T_9 ? 3'h5 : _T_285; // @[Lookup.scala 33:37]
  wire [2:0] _T_287 = _T_7 ? 3'h1 : _T_286; // @[Lookup.scala 33:37]
  wire [2:0] _T_288 = _T_5 ? 3'h4 : _T_287; // @[Lookup.scala 33:37]
  wire [2:0] _T_289 = _T_3 ? 3'h3 : _T_288; // @[Lookup.scala 33:37]
  wire [3:0] _T_297 = _T_83 ? 4'ha : 4'hf; // @[Lookup.scala 33:37]
  wire [3:0] _T_298 = _T_81 ? 4'ha : _T_297; // @[Lookup.scala 33:37]
  wire [3:0] _T_299 = _T_79 ? 4'ha : _T_298; // @[Lookup.scala 33:37]
  wire [3:0] _T_300 = _T_77 ? 4'hf : _T_299; // @[Lookup.scala 33:37]
  wire [3:0] _T_301 = _T_75 ? 4'hf : _T_300; // @[Lookup.scala 33:37]
  wire [3:0] _T_302 = _T_73 ? 4'h2 : _T_301; // @[Lookup.scala 33:37]
  wire [3:0] _T_303 = _T_71 ? 4'h3 : _T_302; // @[Lookup.scala 33:37]
  wire [3:0] _T_304 = _T_69 ? 4'h9 : _T_303; // @[Lookup.scala 33:37]
  wire [3:0] _T_305 = _T_67 ? 4'h8 : _T_304; // @[Lookup.scala 33:37]
  wire [3:0] _T_306 = _T_65 ? 4'h4 : _T_305; // @[Lookup.scala 33:37]
  wire [3:0] _T_307 = _T_63 ? 4'h7 : _T_306; // @[Lookup.scala 33:37]
  wire [3:0] _T_308 = _T_61 ? 4'h5 : _T_307; // @[Lookup.scala 33:37]
  wire [3:0] _T_309 = _T_59 ? 4'h6 : _T_308; // @[Lookup.scala 33:37]
  wire [3:0] _T_310 = _T_57 ? 4'h1 : _T_309; // @[Lookup.scala 33:37]
  wire [3:0] _T_311 = _T_55 ? 4'h0 : _T_310; // @[Lookup.scala 33:37]
  wire [3:0] _T_312 = _T_53 ? 4'h9 : _T_311; // @[Lookup.scala 33:37]
  wire [3:0] _T_313 = _T_51 ? 4'h8 : _T_312; // @[Lookup.scala 33:37]
  wire [3:0] _T_314 = _T_49 ? 4'h6 : _T_313; // @[Lookup.scala 33:37]
  wire [3:0] _T_315 = _T_47 ? 4'h2 : _T_314; // @[Lookup.scala 33:37]
  wire [3:0] _T_316 = _T_45 ? 4'h3 : _T_315; // @[Lookup.scala 33:37]
  wire [3:0] _T_317 = _T_43 ? 4'h4 : _T_316; // @[Lookup.scala 33:37]
  wire [3:0] _T_318 = _T_41 ? 4'h7 : _T_317; // @[Lookup.scala 33:37]
  wire [3:0] _T_319 = _T_39 ? 4'h5 : _T_318; // @[Lookup.scala 33:37]
  wire [3:0] _T_320 = _T_37 ? 4'h0 : _T_319; // @[Lookup.scala 33:37]
  wire [3:0] _T_321 = _T_35 ? 4'h0 : _T_320; // @[Lookup.scala 33:37]
  wire [3:0] _T_322 = _T_33 ? 4'h0 : _T_321; // @[Lookup.scala 33:37]
  wire [3:0] _T_323 = _T_31 ? 4'h0 : _T_322; // @[Lookup.scala 33:37]
  wire [3:0] _T_324 = _T_29 ? 4'h0 : _T_323; // @[Lookup.scala 33:37]
  wire [3:0] _T_325 = _T_27 ? 4'h0 : _T_324; // @[Lookup.scala 33:37]
  wire [3:0] _T_326 = _T_25 ? 4'h0 : _T_325; // @[Lookup.scala 33:37]
  wire [3:0] _T_327 = _T_23 ? 4'h0 : _T_326; // @[Lookup.scala 33:37]
  wire [3:0] _T_328 = _T_21 ? 4'h0 : _T_327; // @[Lookup.scala 33:37]
  wire [3:0] _T_329 = _T_19 ? 4'h0 : _T_328; // @[Lookup.scala 33:37]
  wire [3:0] _T_330 = _T_17 ? 4'h0 : _T_329; // @[Lookup.scala 33:37]
  wire [3:0] _T_331 = _T_15 ? 4'h0 : _T_330; // @[Lookup.scala 33:37]
  wire [3:0] _T_332 = _T_13 ? 4'h0 : _T_331; // @[Lookup.scala 33:37]
  wire [3:0] _T_333 = _T_11 ? 4'h0 : _T_332; // @[Lookup.scala 33:37]
  wire [3:0] _T_334 = _T_9 ? 4'h0 : _T_333; // @[Lookup.scala 33:37]
  wire [3:0] _T_335 = _T_7 ? 4'h0 : _T_334; // @[Lookup.scala 33:37]
  wire [3:0] _T_336 = _T_5 ? 4'h0 : _T_335; // @[Lookup.scala 33:37]
  wire [3:0] _T_337 = _T_3 ? 4'h0 : _T_336; // @[Lookup.scala 33:37]
  wire [2:0] _T_377 = _T_19 ? 3'h4 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _T_378 = _T_17 ? 3'h1 : _T_377; // @[Lookup.scala 33:37]
  wire [2:0] _T_379 = _T_15 ? 3'h5 : _T_378; // @[Lookup.scala 33:37]
  wire [2:0] _T_380 = _T_13 ? 3'h2 : _T_379; // @[Lookup.scala 33:37]
  wire [2:0] _T_381 = _T_11 ? 3'h6 : _T_380; // @[Lookup.scala 33:37]
  wire [2:0] _T_382 = _T_9 ? 3'h3 : _T_381; // @[Lookup.scala 33:37]
  wire [2:0] _T_383 = _T_7 ? 3'h0 : _T_382; // @[Lookup.scala 33:37]
  wire [2:0] _T_384 = _T_5 ? 3'h0 : _T_383; // @[Lookup.scala 33:37]
  wire [2:0] _T_385 = _T_3 ? 3'h0 : _T_384; // @[Lookup.scala 33:37]
  wire  _T_388 = _T_93 ? 1'h0 : _T_95; // @[Lookup.scala 33:37]
  wire  _T_389 = _T_91 ? 1'h0 : _T_388; // @[Lookup.scala 33:37]
  wire  _T_390 = _T_89 | _T_389; // @[Lookup.scala 33:37]
  wire  _T_391 = _T_87 | _T_390; // @[Lookup.scala 33:37]
  wire  _T_392 = _T_85 | _T_391; // @[Lookup.scala 33:37]
  wire  _T_393 = _T_83 | _T_392; // @[Lookup.scala 33:37]
  wire  _T_394 = _T_81 | _T_393; // @[Lookup.scala 33:37]
  wire  _T_395 = _T_79 | _T_394; // @[Lookup.scala 33:37]
  wire  _T_396 = _T_77 | _T_395; // @[Lookup.scala 33:37]
  wire  _T_397 = _T_75 ? 1'h0 : _T_396; // @[Lookup.scala 33:37]
  wire  _T_398 = _T_73 ? 1'h0 : _T_397; // @[Lookup.scala 33:37]
  wire  _T_399 = _T_71 ? 1'h0 : _T_398; // @[Lookup.scala 33:37]
  wire  _T_400 = _T_69 ? 1'h0 : _T_399; // @[Lookup.scala 33:37]
  wire  _T_401 = _T_67 ? 1'h0 : _T_400; // @[Lookup.scala 33:37]
  wire  _T_402 = _T_65 ? 1'h0 : _T_401; // @[Lookup.scala 33:37]
  wire  _T_403 = _T_63 ? 1'h0 : _T_402; // @[Lookup.scala 33:37]
  wire  _T_404 = _T_61 ? 1'h0 : _T_403; // @[Lookup.scala 33:37]
  wire  _T_405 = _T_59 ? 1'h0 : _T_404; // @[Lookup.scala 33:37]
  wire  _T_406 = _T_57 ? 1'h0 : _T_405; // @[Lookup.scala 33:37]
  wire  _T_407 = _T_55 ? 1'h0 : _T_406; // @[Lookup.scala 33:37]
  wire  _T_408 = _T_53 ? 1'h0 : _T_407; // @[Lookup.scala 33:37]
  wire  _T_409 = _T_51 ? 1'h0 : _T_408; // @[Lookup.scala 33:37]
  wire  _T_410 = _T_49 ? 1'h0 : _T_409; // @[Lookup.scala 33:37]
  wire  _T_411 = _T_47 ? 1'h0 : _T_410; // @[Lookup.scala 33:37]
  wire  _T_412 = _T_45 ? 1'h0 : _T_411; // @[Lookup.scala 33:37]
  wire  _T_413 = _T_43 ? 1'h0 : _T_412; // @[Lookup.scala 33:37]
  wire  _T_414 = _T_41 ? 1'h0 : _T_413; // @[Lookup.scala 33:37]
  wire  _T_415 = _T_39 ? 1'h0 : _T_414; // @[Lookup.scala 33:37]
  wire  _T_416 = _T_37 ? 1'h0 : _T_415; // @[Lookup.scala 33:37]
  wire  _T_417 = _T_35 ? 1'h0 : _T_416; // @[Lookup.scala 33:37]
  wire  _T_418 = _T_33 ? 1'h0 : _T_417; // @[Lookup.scala 33:37]
  wire  _T_419 = _T_31 ? 1'h0 : _T_418; // @[Lookup.scala 33:37]
  wire  _T_420 = _T_29 | _T_419; // @[Lookup.scala 33:37]
  wire  _T_421 = _T_27 | _T_420; // @[Lookup.scala 33:37]
  wire  _T_422 = _T_25 | _T_421; // @[Lookup.scala 33:37]
  wire  _T_423 = _T_23 | _T_422; // @[Lookup.scala 33:37]
  wire  _T_424 = _T_21 | _T_423; // @[Lookup.scala 33:37]
  wire  _T_425 = _T_19 ? 1'h0 : _T_424; // @[Lookup.scala 33:37]
  wire  _T_426 = _T_17 ? 1'h0 : _T_425; // @[Lookup.scala 33:37]
  wire  _T_427 = _T_15 ? 1'h0 : _T_426; // @[Lookup.scala 33:37]
  wire  _T_428 = _T_13 ? 1'h0 : _T_427; // @[Lookup.scala 33:37]
  wire  _T_429 = _T_11 ? 1'h0 : _T_428; // @[Lookup.scala 33:37]
  wire  _T_430 = _T_9 ? 1'h0 : _T_429; // @[Lookup.scala 33:37]
  wire  _T_431 = _T_7 | _T_430; // @[Lookup.scala 33:37]
  wire  _T_432 = _T_5 | _T_431; // @[Lookup.scala 33:37]
  wire  _T_433 = _T_3 ? 1'h0 : _T_432; // @[Lookup.scala 33:37]
  wire [1:0] _T_465 = _T_35 ? 2'h1 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _T_466 = _T_33 ? 2'h2 : _T_465; // @[Lookup.scala 33:37]
  wire [1:0] _T_467 = _T_31 ? 2'h3 : _T_466; // @[Lookup.scala 33:37]
  wire [1:0] _T_468 = _T_29 ? 2'h0 : _T_467; // @[Lookup.scala 33:37]
  wire [1:0] _T_469 = _T_27 ? 2'h0 : _T_468; // @[Lookup.scala 33:37]
  wire [1:0] _T_470 = _T_25 ? 2'h0 : _T_469; // @[Lookup.scala 33:37]
  wire [1:0] _T_471 = _T_23 ? 2'h0 : _T_470; // @[Lookup.scala 33:37]
  wire [1:0] _T_472 = _T_21 ? 2'h0 : _T_471; // @[Lookup.scala 33:37]
  wire [1:0] _T_473 = _T_19 ? 2'h0 : _T_472; // @[Lookup.scala 33:37]
  wire [1:0] _T_474 = _T_17 ? 2'h0 : _T_473; // @[Lookup.scala 33:37]
  wire [1:0] _T_475 = _T_15 ? 2'h0 : _T_474; // @[Lookup.scala 33:37]
  wire [1:0] _T_476 = _T_13 ? 2'h0 : _T_475; // @[Lookup.scala 33:37]
  wire [1:0] _T_477 = _T_11 ? 2'h0 : _T_476; // @[Lookup.scala 33:37]
  wire [1:0] _T_478 = _T_9 ? 2'h0 : _T_477; // @[Lookup.scala 33:37]
  wire [1:0] _T_479 = _T_7 ? 2'h0 : _T_478; // @[Lookup.scala 33:37]
  wire [1:0] _T_480 = _T_5 ? 2'h0 : _T_479; // @[Lookup.scala 33:37]
  wire [1:0] _T_481 = _T_3 ? 2'h0 : _T_480; // @[Lookup.scala 33:37]
  wire [2:0] _T_516 = _T_29 ? 3'h4 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _T_517 = _T_27 ? 3'h5 : _T_516; // @[Lookup.scala 33:37]
  wire [2:0] _T_518 = _T_25 ? 3'h1 : _T_517; // @[Lookup.scala 33:37]
  wire [2:0] _T_519 = _T_23 ? 3'h2 : _T_518; // @[Lookup.scala 33:37]
  wire [2:0] _T_520 = _T_21 ? 3'h3 : _T_519; // @[Lookup.scala 33:37]
  wire [2:0] _T_521 = _T_19 ? 3'h0 : _T_520; // @[Lookup.scala 33:37]
  wire [2:0] _T_522 = _T_17 ? 3'h0 : _T_521; // @[Lookup.scala 33:37]
  wire [2:0] _T_523 = _T_15 ? 3'h0 : _T_522; // @[Lookup.scala 33:37]
  wire [2:0] _T_524 = _T_13 ? 3'h0 : _T_523; // @[Lookup.scala 33:37]
  wire [2:0] _T_525 = _T_11 ? 3'h0 : _T_524; // @[Lookup.scala 33:37]
  wire [2:0] _T_526 = _T_9 ? 3'h0 : _T_525; // @[Lookup.scala 33:37]
  wire [2:0] _T_527 = _T_7 ? 3'h0 : _T_526; // @[Lookup.scala 33:37]
  wire [2:0] _T_528 = _T_5 ? 3'h0 : _T_527; // @[Lookup.scala 33:37]
  wire [2:0] _T_529 = _T_3 ? 3'h0 : _T_528; // @[Lookup.scala 33:37]
  wire [1:0] _T_532 = _T_93 ? 2'h3 : _T_99; // @[Lookup.scala 33:37]
  wire [1:0] _T_533 = _T_91 ? 2'h3 : _T_532; // @[Lookup.scala 33:37]
  wire [1:0] _T_534 = _T_89 ? 2'h3 : _T_533; // @[Lookup.scala 33:37]
  wire [1:0] _T_535 = _T_87 ? 2'h3 : _T_534; // @[Lookup.scala 33:37]
  wire [1:0] _T_536 = _T_85 ? 2'h3 : _T_535; // @[Lookup.scala 33:37]
  wire [1:0] _T_537 = _T_83 ? 2'h3 : _T_536; // @[Lookup.scala 33:37]
  wire [1:0] _T_538 = _T_81 ? 2'h3 : _T_537; // @[Lookup.scala 33:37]
  wire [1:0] _T_539 = _T_79 ? 2'h3 : _T_538; // @[Lookup.scala 33:37]
  wire [1:0] _T_540 = _T_77 ? 2'h0 : _T_539; // @[Lookup.scala 33:37]
  wire [1:0] _T_541 = _T_75 ? 2'h0 : _T_540; // @[Lookup.scala 33:37]
  wire [1:0] _T_542 = _T_73 ? 2'h0 : _T_541; // @[Lookup.scala 33:37]
  wire [1:0] _T_543 = _T_71 ? 2'h0 : _T_542; // @[Lookup.scala 33:37]
  wire [1:0] _T_544 = _T_69 ? 2'h0 : _T_543; // @[Lookup.scala 33:37]
  wire [1:0] _T_545 = _T_67 ? 2'h0 : _T_544; // @[Lookup.scala 33:37]
  wire [1:0] _T_546 = _T_65 ? 2'h0 : _T_545; // @[Lookup.scala 33:37]
  wire [1:0] _T_547 = _T_63 ? 2'h0 : _T_546; // @[Lookup.scala 33:37]
  wire [1:0] _T_548 = _T_61 ? 2'h0 : _T_547; // @[Lookup.scala 33:37]
  wire [1:0] _T_549 = _T_59 ? 2'h0 : _T_548; // @[Lookup.scala 33:37]
  wire [1:0] _T_550 = _T_57 ? 2'h0 : _T_549; // @[Lookup.scala 33:37]
  wire [1:0] _T_551 = _T_55 ? 2'h0 : _T_550; // @[Lookup.scala 33:37]
  wire [1:0] _T_552 = _T_53 ? 2'h0 : _T_551; // @[Lookup.scala 33:37]
  wire [1:0] _T_553 = _T_51 ? 2'h0 : _T_552; // @[Lookup.scala 33:37]
  wire [1:0] _T_554 = _T_49 ? 2'h0 : _T_553; // @[Lookup.scala 33:37]
  wire [1:0] _T_555 = _T_47 ? 2'h0 : _T_554; // @[Lookup.scala 33:37]
  wire [1:0] _T_556 = _T_45 ? 2'h0 : _T_555; // @[Lookup.scala 33:37]
  wire [1:0] _T_557 = _T_43 ? 2'h0 : _T_556; // @[Lookup.scala 33:37]
  wire [1:0] _T_558 = _T_41 ? 2'h0 : _T_557; // @[Lookup.scala 33:37]
  wire [1:0] _T_559 = _T_39 ? 2'h0 : _T_558; // @[Lookup.scala 33:37]
  wire [1:0] _T_560 = _T_37 ? 2'h0 : _T_559; // @[Lookup.scala 33:37]
  wire [1:0] _T_561 = _T_35 ? 2'h0 : _T_560; // @[Lookup.scala 33:37]
  wire [1:0] _T_562 = _T_33 ? 2'h0 : _T_561; // @[Lookup.scala 33:37]
  wire [1:0] _T_563 = _T_31 ? 2'h0 : _T_562; // @[Lookup.scala 33:37]
  wire [1:0] _T_564 = _T_29 ? 2'h1 : _T_563; // @[Lookup.scala 33:37]
  wire [1:0] _T_565 = _T_27 ? 2'h1 : _T_564; // @[Lookup.scala 33:37]
  wire [1:0] _T_566 = _T_25 ? 2'h1 : _T_565; // @[Lookup.scala 33:37]
  wire [1:0] _T_567 = _T_23 ? 2'h1 : _T_566; // @[Lookup.scala 33:37]
  wire [1:0] _T_568 = _T_21 ? 2'h1 : _T_567; // @[Lookup.scala 33:37]
  wire [1:0] _T_569 = _T_19 ? 2'h0 : _T_568; // @[Lookup.scala 33:37]
  wire [1:0] _T_570 = _T_17 ? 2'h0 : _T_569; // @[Lookup.scala 33:37]
  wire [1:0] _T_571 = _T_15 ? 2'h0 : _T_570; // @[Lookup.scala 33:37]
  wire [1:0] _T_572 = _T_13 ? 2'h0 : _T_571; // @[Lookup.scala 33:37]
  wire [1:0] _T_573 = _T_11 ? 2'h0 : _T_572; // @[Lookup.scala 33:37]
  wire [1:0] _T_574 = _T_9 ? 2'h0 : _T_573; // @[Lookup.scala 33:37]
  wire [1:0] _T_575 = _T_7 ? 2'h2 : _T_574; // @[Lookup.scala 33:37]
  wire [1:0] _T_576 = _T_5 ? 2'h2 : _T_575; // @[Lookup.scala 33:37]
  wire [1:0] _T_577 = _T_3 ? 2'h0 : _T_576; // @[Lookup.scala 33:37]
  wire  _T_583 = _T_87 | _T_89; // @[Lookup.scala 33:37]
  wire  _T_584 = _T_85 | _T_583; // @[Lookup.scala 33:37]
  wire  _T_585 = _T_83 | _T_584; // @[Lookup.scala 33:37]
  wire  _T_586 = _T_81 | _T_585; // @[Lookup.scala 33:37]
  wire  _T_587 = _T_79 | _T_586; // @[Lookup.scala 33:37]
  wire  _T_588 = _T_77 ? 1'h0 : _T_587; // @[Lookup.scala 33:37]
  wire  _T_589 = _T_75 ? 1'h0 : _T_588; // @[Lookup.scala 33:37]
  wire  _T_590 = _T_73 | _T_589; // @[Lookup.scala 33:37]
  wire  _T_591 = _T_71 | _T_590; // @[Lookup.scala 33:37]
  wire  _T_592 = _T_69 | _T_591; // @[Lookup.scala 33:37]
  wire  _T_593 = _T_67 | _T_592; // @[Lookup.scala 33:37]
  wire  _T_594 = _T_65 | _T_593; // @[Lookup.scala 33:37]
  wire  _T_595 = _T_63 | _T_594; // @[Lookup.scala 33:37]
  wire  _T_596 = _T_61 | _T_595; // @[Lookup.scala 33:37]
  wire  _T_597 = _T_59 | _T_596; // @[Lookup.scala 33:37]
  wire  _T_598 = _T_57 | _T_597; // @[Lookup.scala 33:37]
  wire  _T_599 = _T_55 | _T_598; // @[Lookup.scala 33:37]
  wire  _T_600 = _T_53 | _T_599; // @[Lookup.scala 33:37]
  wire  _T_601 = _T_51 | _T_600; // @[Lookup.scala 33:37]
  wire  _T_602 = _T_49 | _T_601; // @[Lookup.scala 33:37]
  wire  _T_603 = _T_47 | _T_602; // @[Lookup.scala 33:37]
  wire  _T_604 = _T_45 | _T_603; // @[Lookup.scala 33:37]
  wire  _T_605 = _T_43 | _T_604; // @[Lookup.scala 33:37]
  wire  _T_606 = _T_41 | _T_605; // @[Lookup.scala 33:37]
  wire  _T_607 = _T_39 | _T_606; // @[Lookup.scala 33:37]
  wire  _T_608 = _T_37 | _T_607; // @[Lookup.scala 33:37]
  wire  _T_609 = _T_35 ? 1'h0 : _T_608; // @[Lookup.scala 33:37]
  wire  _T_610 = _T_33 ? 1'h0 : _T_609; // @[Lookup.scala 33:37]
  wire  _T_611 = _T_31 ? 1'h0 : _T_610; // @[Lookup.scala 33:37]
  wire  _T_612 = _T_29 | _T_611; // @[Lookup.scala 33:37]
  wire  _T_613 = _T_27 | _T_612; // @[Lookup.scala 33:37]
  wire  _T_614 = _T_25 | _T_613; // @[Lookup.scala 33:37]
  wire  _T_615 = _T_23 | _T_614; // @[Lookup.scala 33:37]
  wire  _T_616 = _T_21 | _T_615; // @[Lookup.scala 33:37]
  wire  _T_617 = _T_19 ? 1'h0 : _T_616; // @[Lookup.scala 33:37]
  wire  _T_618 = _T_17 ? 1'h0 : _T_617; // @[Lookup.scala 33:37]
  wire  _T_619 = _T_15 ? 1'h0 : _T_618; // @[Lookup.scala 33:37]
  wire  _T_620 = _T_13 ? 1'h0 : _T_619; // @[Lookup.scala 33:37]
  wire  _T_621 = _T_11 ? 1'h0 : _T_620; // @[Lookup.scala 33:37]
  wire  _T_622 = _T_9 ? 1'h0 : _T_621; // @[Lookup.scala 33:37]
  wire  _T_623 = _T_7 | _T_622; // @[Lookup.scala 33:37]
  wire  _T_624 = _T_5 | _T_623; // @[Lookup.scala 33:37]
  wire  _T_625 = _T_3 | _T_624; // @[Lookup.scala 33:37]
  wire [2:0] _T_627 = _T_95 ? 3'h4 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _T_628 = _T_93 ? 3'h4 : _T_627; // @[Lookup.scala 33:37]
  wire [2:0] _T_629 = _T_91 ? 3'h4 : _T_628; // @[Lookup.scala 33:37]
  wire [2:0] _T_630 = _T_89 ? 3'h3 : _T_629; // @[Lookup.scala 33:37]
  wire [2:0] _T_631 = _T_87 ? 3'h2 : _T_630; // @[Lookup.scala 33:37]
  wire [2:0] _T_632 = _T_85 ? 3'h1 : _T_631; // @[Lookup.scala 33:37]
  wire [2:0] _T_633 = _T_83 ? 3'h3 : _T_632; // @[Lookup.scala 33:37]
  wire [2:0] _T_634 = _T_81 ? 3'h2 : _T_633; // @[Lookup.scala 33:37]
  wire [2:0] _T_635 = _T_79 ? 3'h1 : _T_634; // @[Lookup.scala 33:37]
  wire [2:0] _T_636 = _T_77 ? 3'h0 : _T_635; // @[Lookup.scala 33:37]
  wire [2:0] _T_637 = _T_75 ? 3'h0 : _T_636; // @[Lookup.scala 33:37]
  wire [2:0] _T_638 = _T_73 ? 3'h0 : _T_637; // @[Lookup.scala 33:37]
  wire [2:0] _T_639 = _T_71 ? 3'h0 : _T_638; // @[Lookup.scala 33:37]
  wire [2:0] _T_640 = _T_69 ? 3'h0 : _T_639; // @[Lookup.scala 33:37]
  wire [2:0] _T_641 = _T_67 ? 3'h0 : _T_640; // @[Lookup.scala 33:37]
  wire [2:0] _T_642 = _T_65 ? 3'h0 : _T_641; // @[Lookup.scala 33:37]
  wire [2:0] _T_643 = _T_63 ? 3'h0 : _T_642; // @[Lookup.scala 33:37]
  wire [2:0] _T_644 = _T_61 ? 3'h0 : _T_643; // @[Lookup.scala 33:37]
  wire [2:0] _T_645 = _T_59 ? 3'h0 : _T_644; // @[Lookup.scala 33:37]
  wire [2:0] _T_646 = _T_57 ? 3'h0 : _T_645; // @[Lookup.scala 33:37]
  wire [2:0] _T_647 = _T_55 ? 3'h0 : _T_646; // @[Lookup.scala 33:37]
  wire [2:0] _T_648 = _T_53 ? 3'h0 : _T_647; // @[Lookup.scala 33:37]
  wire [2:0] _T_649 = _T_51 ? 3'h0 : _T_648; // @[Lookup.scala 33:37]
  wire [2:0] _T_650 = _T_49 ? 3'h0 : _T_649; // @[Lookup.scala 33:37]
  wire [2:0] _T_651 = _T_47 ? 3'h0 : _T_650; // @[Lookup.scala 33:37]
  wire [2:0] _T_652 = _T_45 ? 3'h0 : _T_651; // @[Lookup.scala 33:37]
  wire [2:0] _T_653 = _T_43 ? 3'h0 : _T_652; // @[Lookup.scala 33:37]
  wire [2:0] _T_654 = _T_41 ? 3'h0 : _T_653; // @[Lookup.scala 33:37]
  wire [2:0] _T_655 = _T_39 ? 3'h0 : _T_654; // @[Lookup.scala 33:37]
  wire [2:0] _T_656 = _T_37 ? 3'h0 : _T_655; // @[Lookup.scala 33:37]
  wire [2:0] _T_657 = _T_35 ? 3'h0 : _T_656; // @[Lookup.scala 33:37]
  wire [2:0] _T_658 = _T_33 ? 3'h0 : _T_657; // @[Lookup.scala 33:37]
  wire [2:0] _T_659 = _T_31 ? 3'h0 : _T_658; // @[Lookup.scala 33:37]
  wire [2:0] _T_660 = _T_29 ? 3'h0 : _T_659; // @[Lookup.scala 33:37]
  wire [2:0] _T_661 = _T_27 ? 3'h0 : _T_660; // @[Lookup.scala 33:37]
  wire [2:0] _T_662 = _T_25 ? 3'h0 : _T_661; // @[Lookup.scala 33:37]
  wire [2:0] _T_663 = _T_23 ? 3'h0 : _T_662; // @[Lookup.scala 33:37]
  wire [2:0] _T_664 = _T_21 ? 3'h0 : _T_663; // @[Lookup.scala 33:37]
  wire [2:0] _T_665 = _T_19 ? 3'h0 : _T_664; // @[Lookup.scala 33:37]
  wire [2:0] _T_666 = _T_17 ? 3'h0 : _T_665; // @[Lookup.scala 33:37]
  wire [2:0] _T_667 = _T_15 ? 3'h0 : _T_666; // @[Lookup.scala 33:37]
  wire [2:0] _T_668 = _T_13 ? 3'h0 : _T_667; // @[Lookup.scala 33:37]
  wire [2:0] _T_669 = _T_11 ? 3'h0 : _T_668; // @[Lookup.scala 33:37]
  wire [2:0] _T_670 = _T_9 ? 3'h0 : _T_669; // @[Lookup.scala 33:37]
  wire [2:0] _T_671 = _T_7 ? 3'h0 : _T_670; // @[Lookup.scala 33:37]
  wire [2:0] _T_672 = _T_5 ? 3'h0 : _T_671; // @[Lookup.scala 33:37]
  wire [2:0] _T_673 = _T_3 ? 3'h0 : _T_672; // @[Lookup.scala 33:37]
  wire  _T_674 = _T_97 ? 1'h0 : 1'h1; // @[Lookup.scala 33:37]
  wire  _T_675 = _T_95 ? 1'h0 : _T_674; // @[Lookup.scala 33:37]
  wire  _T_676 = _T_93 ? 1'h0 : _T_675; // @[Lookup.scala 33:37]
  wire  _T_677 = _T_91 ? 1'h0 : _T_676; // @[Lookup.scala 33:37]
  wire  _T_678 = _T_89 ? 1'h0 : _T_677; // @[Lookup.scala 33:37]
  wire  _T_679 = _T_87 ? 1'h0 : _T_678; // @[Lookup.scala 33:37]
  wire  _T_680 = _T_85 ? 1'h0 : _T_679; // @[Lookup.scala 33:37]
  wire  _T_681 = _T_83 ? 1'h0 : _T_680; // @[Lookup.scala 33:37]
  wire  _T_682 = _T_81 ? 1'h0 : _T_681; // @[Lookup.scala 33:37]
  wire  _T_683 = _T_79 ? 1'h0 : _T_682; // @[Lookup.scala 33:37]
  wire  _T_684 = _T_77 ? 1'h0 : _T_683; // @[Lookup.scala 33:37]
  wire  _T_685 = _T_75 ? 1'h0 : _T_684; // @[Lookup.scala 33:37]
  wire  _T_686 = _T_73 ? 1'h0 : _T_685; // @[Lookup.scala 33:37]
  wire  _T_687 = _T_71 ? 1'h0 : _T_686; // @[Lookup.scala 33:37]
  wire  _T_688 = _T_69 ? 1'h0 : _T_687; // @[Lookup.scala 33:37]
  wire  _T_689 = _T_67 ? 1'h0 : _T_688; // @[Lookup.scala 33:37]
  wire  _T_690 = _T_65 ? 1'h0 : _T_689; // @[Lookup.scala 33:37]
  wire  _T_691 = _T_63 ? 1'h0 : _T_690; // @[Lookup.scala 33:37]
  wire  _T_692 = _T_61 ? 1'h0 : _T_691; // @[Lookup.scala 33:37]
  wire  _T_693 = _T_59 ? 1'h0 : _T_692; // @[Lookup.scala 33:37]
  wire  _T_694 = _T_57 ? 1'h0 : _T_693; // @[Lookup.scala 33:37]
  wire  _T_695 = _T_55 ? 1'h0 : _T_694; // @[Lookup.scala 33:37]
  wire  _T_696 = _T_53 ? 1'h0 : _T_695; // @[Lookup.scala 33:37]
  wire  _T_697 = _T_51 ? 1'h0 : _T_696; // @[Lookup.scala 33:37]
  wire  _T_698 = _T_49 ? 1'h0 : _T_697; // @[Lookup.scala 33:37]
  wire  _T_699 = _T_47 ? 1'h0 : _T_698; // @[Lookup.scala 33:37]
  wire  _T_700 = _T_45 ? 1'h0 : _T_699; // @[Lookup.scala 33:37]
  wire  _T_701 = _T_43 ? 1'h0 : _T_700; // @[Lookup.scala 33:37]
  wire  _T_702 = _T_41 ? 1'h0 : _T_701; // @[Lookup.scala 33:37]
  wire  _T_703 = _T_39 ? 1'h0 : _T_702; // @[Lookup.scala 33:37]
  wire  _T_704 = _T_37 ? 1'h0 : _T_703; // @[Lookup.scala 33:37]
  wire  _T_705 = _T_35 ? 1'h0 : _T_704; // @[Lookup.scala 33:37]
  wire  _T_706 = _T_33 ? 1'h0 : _T_705; // @[Lookup.scala 33:37]
  wire  _T_707 = _T_31 ? 1'h0 : _T_706; // @[Lookup.scala 33:37]
  wire  _T_708 = _T_29 ? 1'h0 : _T_707; // @[Lookup.scala 33:37]
  wire  _T_709 = _T_27 ? 1'h0 : _T_708; // @[Lookup.scala 33:37]
  wire  _T_710 = _T_25 ? 1'h0 : _T_709; // @[Lookup.scala 33:37]
  wire  _T_711 = _T_23 ? 1'h0 : _T_710; // @[Lookup.scala 33:37]
  wire  _T_712 = _T_21 ? 1'h0 : _T_711; // @[Lookup.scala 33:37]
  wire  _T_713 = _T_19 ? 1'h0 : _T_712; // @[Lookup.scala 33:37]
  wire  _T_714 = _T_17 ? 1'h0 : _T_713; // @[Lookup.scala 33:37]
  wire  _T_715 = _T_15 ? 1'h0 : _T_714; // @[Lookup.scala 33:37]
  wire  _T_716 = _T_13 ? 1'h0 : _T_715; // @[Lookup.scala 33:37]
  wire  _T_717 = _T_11 ? 1'h0 : _T_716; // @[Lookup.scala 33:37]
  wire  _T_718 = _T_9 ? 1'h0 : _T_717; // @[Lookup.scala 33:37]
  wire  _T_719 = _T_7 ? 1'h0 : _T_718; // @[Lookup.scala 33:37]
  wire  _T_720 = _T_5 ? 1'h0 : _T_719; // @[Lookup.scala 33:37]
  wire  _T_721 = _T_3 ? 1'h0 : _T_720; // @[Lookup.scala 33:37]
  assign io_pc_sel = _T_1 ? 2'h0 : _T_145; // @[Control.scala 149:16]
  assign io_inst_kill = _T_1 ? 1'h0 : _T_433; // @[Control.scala 150:16]
  assign io_A_sel = _T_1 ? 1'h0 : _T_193; // @[Control.scala 153:14]
  assign io_B_sel = _T_1 ? 1'h0 : _T_241; // @[Control.scala 154:14]
  assign io_imm_sel = _T_1 ? 3'h3 : _T_289; // @[Control.scala 155:14]
  assign io_alu_op = _T_1 ? 4'hb : _T_337; // @[Control.scala 156:14]
  assign io_br_type = _T_1 ? 3'h0 : _T_385; // @[Control.scala 157:14]
  assign io_st_type = _T_1 ? 2'h0 : _T_481; // @[Control.scala 158:14]
  assign io_ld_type = _T_1 ? 3'h0 : _T_529; // @[Control.scala 161:14]
  assign io_wb_sel = _T_1 ? 2'h0 : _T_577; // @[Control.scala 162:14]
  assign io_wb_en = _T_1 | _T_625; // @[Control.scala 163:14]
  assign io_csr_cmd = _T_1 ? 3'h0 : _T_673; // @[Control.scala 164:14]
  assign io_illegal = _T_1 ? 1'h0 : _T_721; // @[Control.scala 165:14]
endmodule
module Core(
  input         clock,
  input         reset,
  input         io_host_fromhost_valid,
  input  [31:0] io_host_fromhost_bits,
  output [31:0] io_host_tohost,
  output        io_icache_req_valid,
  output [31:0] io_icache_req_bits_addr,
  input         io_icache_resp_valid,
  input  [31:0] io_icache_resp_bits_data,
  output        io_dcache_abort,
  output        io_dcache_req_valid,
  output [31:0] io_dcache_req_bits_addr,
  output [31:0] io_dcache_req_bits_data,
  output [3:0]  io_dcache_req_bits_mask,
  input         io_dcache_resp_valid,
  input  [31:0] io_dcache_resp_bits_data
);
  wire  dpath_clock; // @[Core.scala 35:21]
  wire  dpath_reset; // @[Core.scala 35:21]
  wire  dpath_io_host_fromhost_valid; // @[Core.scala 35:21]
  wire [31:0] dpath_io_host_fromhost_bits; // @[Core.scala 35:21]
  wire [31:0] dpath_io_host_tohost; // @[Core.scala 35:21]
  wire  dpath_io_icache_req_valid; // @[Core.scala 35:21]
  wire [31:0] dpath_io_icache_req_bits_addr; // @[Core.scala 35:21]
  wire  dpath_io_icache_resp_valid; // @[Core.scala 35:21]
  wire [31:0] dpath_io_icache_resp_bits_data; // @[Core.scala 35:21]
  wire  dpath_io_dcache_abort; // @[Core.scala 35:21]
  wire  dpath_io_dcache_req_valid; // @[Core.scala 35:21]
  wire [31:0] dpath_io_dcache_req_bits_addr; // @[Core.scala 35:21]
  wire [31:0] dpath_io_dcache_req_bits_data; // @[Core.scala 35:21]
  wire [3:0] dpath_io_dcache_req_bits_mask; // @[Core.scala 35:21]
  wire  dpath_io_dcache_resp_valid; // @[Core.scala 35:21]
  wire [31:0] dpath_io_dcache_resp_bits_data; // @[Core.scala 35:21]
  wire [31:0] dpath_io_ctrl_inst; // @[Core.scala 35:21]
  wire [1:0] dpath_io_ctrl_pc_sel; // @[Core.scala 35:21]
  wire  dpath_io_ctrl_inst_kill; // @[Core.scala 35:21]
  wire  dpath_io_ctrl_A_sel; // @[Core.scala 35:21]
  wire  dpath_io_ctrl_B_sel; // @[Core.scala 35:21]
  wire [2:0] dpath_io_ctrl_imm_sel; // @[Core.scala 35:21]
  wire [3:0] dpath_io_ctrl_alu_op; // @[Core.scala 35:21]
  wire [2:0] dpath_io_ctrl_br_type; // @[Core.scala 35:21]
  wire [1:0] dpath_io_ctrl_st_type; // @[Core.scala 35:21]
  wire [2:0] dpath_io_ctrl_ld_type; // @[Core.scala 35:21]
  wire [1:0] dpath_io_ctrl_wb_sel; // @[Core.scala 35:21]
  wire  dpath_io_ctrl_wb_en; // @[Core.scala 35:21]
  wire [2:0] dpath_io_ctrl_csr_cmd; // @[Core.scala 35:21]
  wire  dpath_io_ctrl_illegal; // @[Core.scala 35:21]
  wire [31:0] ctrl_io_inst; // @[Core.scala 36:21]
  wire [1:0] ctrl_io_pc_sel; // @[Core.scala 36:21]
  wire  ctrl_io_inst_kill; // @[Core.scala 36:21]
  wire  ctrl_io_A_sel; // @[Core.scala 36:21]
  wire  ctrl_io_B_sel; // @[Core.scala 36:21]
  wire [2:0] ctrl_io_imm_sel; // @[Core.scala 36:21]
  wire [3:0] ctrl_io_alu_op; // @[Core.scala 36:21]
  wire [2:0] ctrl_io_br_type; // @[Core.scala 36:21]
  wire [1:0] ctrl_io_st_type; // @[Core.scala 36:21]
  wire [2:0] ctrl_io_ld_type; // @[Core.scala 36:21]
  wire [1:0] ctrl_io_wb_sel; // @[Core.scala 36:21]
  wire  ctrl_io_wb_en; // @[Core.scala 36:21]
  wire [2:0] ctrl_io_csr_cmd; // @[Core.scala 36:21]
  wire  ctrl_io_illegal; // @[Core.scala 36:21]
  Datapath dpath ( // @[Core.scala 35:21]
    .clock(dpath_clock),
    .reset(dpath_reset),
    .io_host_fromhost_valid(dpath_io_host_fromhost_valid),
    .io_host_fromhost_bits(dpath_io_host_fromhost_bits),
    .io_host_tohost(dpath_io_host_tohost),
    .io_icache_req_valid(dpath_io_icache_req_valid),
    .io_icache_req_bits_addr(dpath_io_icache_req_bits_addr),
    .io_icache_resp_valid(dpath_io_icache_resp_valid),
    .io_icache_resp_bits_data(dpath_io_icache_resp_bits_data),
    .io_dcache_abort(dpath_io_dcache_abort),
    .io_dcache_req_valid(dpath_io_dcache_req_valid),
    .io_dcache_req_bits_addr(dpath_io_dcache_req_bits_addr),
    .io_dcache_req_bits_data(dpath_io_dcache_req_bits_data),
    .io_dcache_req_bits_mask(dpath_io_dcache_req_bits_mask),
    .io_dcache_resp_valid(dpath_io_dcache_resp_valid),
    .io_dcache_resp_bits_data(dpath_io_dcache_resp_bits_data),
    .io_ctrl_inst(dpath_io_ctrl_inst),
    .io_ctrl_pc_sel(dpath_io_ctrl_pc_sel),
    .io_ctrl_inst_kill(dpath_io_ctrl_inst_kill),
    .io_ctrl_A_sel(dpath_io_ctrl_A_sel),
    .io_ctrl_B_sel(dpath_io_ctrl_B_sel),
    .io_ctrl_imm_sel(dpath_io_ctrl_imm_sel),
    .io_ctrl_alu_op(dpath_io_ctrl_alu_op),
    .io_ctrl_br_type(dpath_io_ctrl_br_type),
    .io_ctrl_st_type(dpath_io_ctrl_st_type),
    .io_ctrl_ld_type(dpath_io_ctrl_ld_type),
    .io_ctrl_wb_sel(dpath_io_ctrl_wb_sel),
    .io_ctrl_wb_en(dpath_io_ctrl_wb_en),
    .io_ctrl_csr_cmd(dpath_io_ctrl_csr_cmd),
    .io_ctrl_illegal(dpath_io_ctrl_illegal)
  );
  Control ctrl ( // @[Core.scala 36:21]
    .io_inst(ctrl_io_inst),
    .io_pc_sel(ctrl_io_pc_sel),
    .io_inst_kill(ctrl_io_inst_kill),
    .io_A_sel(ctrl_io_A_sel),
    .io_B_sel(ctrl_io_B_sel),
    .io_imm_sel(ctrl_io_imm_sel),
    .io_alu_op(ctrl_io_alu_op),
    .io_br_type(ctrl_io_br_type),
    .io_st_type(ctrl_io_st_type),
    .io_ld_type(ctrl_io_ld_type),
    .io_wb_sel(ctrl_io_wb_sel),
    .io_wb_en(ctrl_io_wb_en),
    .io_csr_cmd(ctrl_io_csr_cmd),
    .io_illegal(ctrl_io_illegal)
  );
  assign io_host_tohost = dpath_io_host_tohost; // @[Core.scala 38:11]
  assign io_icache_req_valid = dpath_io_icache_req_valid; // @[Core.scala 39:19]
  assign io_icache_req_bits_addr = dpath_io_icache_req_bits_addr; // @[Core.scala 39:19]
  assign io_dcache_abort = dpath_io_dcache_abort; // @[Core.scala 40:19]
  assign io_dcache_req_valid = dpath_io_dcache_req_valid; // @[Core.scala 40:19]
  assign io_dcache_req_bits_addr = dpath_io_dcache_req_bits_addr; // @[Core.scala 40:19]
  assign io_dcache_req_bits_data = dpath_io_dcache_req_bits_data; // @[Core.scala 40:19]
  assign io_dcache_req_bits_mask = dpath_io_dcache_req_bits_mask; // @[Core.scala 40:19]
  assign dpath_clock = clock;
  assign dpath_reset = reset;
  assign dpath_io_host_fromhost_valid = io_host_fromhost_valid; // @[Core.scala 38:11]
  assign dpath_io_host_fromhost_bits = io_host_fromhost_bits; // @[Core.scala 38:11]
  assign dpath_io_icache_resp_valid = io_icache_resp_valid; // @[Core.scala 39:19]
  assign dpath_io_icache_resp_bits_data = io_icache_resp_bits_data; // @[Core.scala 39:19]
  assign dpath_io_dcache_resp_valid = io_dcache_resp_valid; // @[Core.scala 40:19]
  assign dpath_io_dcache_resp_bits_data = io_dcache_resp_bits_data; // @[Core.scala 40:19]
  assign dpath_io_ctrl_pc_sel = ctrl_io_pc_sel; // @[Core.scala 41:17]
  assign dpath_io_ctrl_inst_kill = ctrl_io_inst_kill; // @[Core.scala 41:17]
  assign dpath_io_ctrl_A_sel = ctrl_io_A_sel; // @[Core.scala 41:17]
  assign dpath_io_ctrl_B_sel = ctrl_io_B_sel; // @[Core.scala 41:17]
  assign dpath_io_ctrl_imm_sel = ctrl_io_imm_sel; // @[Core.scala 41:17]
  assign dpath_io_ctrl_alu_op = ctrl_io_alu_op; // @[Core.scala 41:17]
  assign dpath_io_ctrl_br_type = ctrl_io_br_type; // @[Core.scala 41:17]
  assign dpath_io_ctrl_st_type = ctrl_io_st_type; // @[Core.scala 41:17]
  assign dpath_io_ctrl_ld_type = ctrl_io_ld_type; // @[Core.scala 41:17]
  assign dpath_io_ctrl_wb_sel = ctrl_io_wb_sel; // @[Core.scala 41:17]
  assign dpath_io_ctrl_wb_en = ctrl_io_wb_en; // @[Core.scala 41:17]
  assign dpath_io_ctrl_csr_cmd = ctrl_io_csr_cmd; // @[Core.scala 41:17]
  assign dpath_io_ctrl_illegal = ctrl_io_illegal; // @[Core.scala 41:17]
  assign ctrl_io_inst = dpath_io_ctrl_inst; // @[Core.scala 41:17]
endmodule
module Cache(
  input         clock,
  input         reset,
  input         io_cpu_abort,
  input         io_cpu_req_valid,
  input  [31:0] io_cpu_req_bits_addr,
  input  [31:0] io_cpu_req_bits_data,
  input  [3:0]  io_cpu_req_bits_mask,
  output        io_cpu_resp_valid,
  output [31:0] io_cpu_resp_bits_data,
  input         io_nasti_aw_ready,
  output        io_nasti_aw_valid,
  output [31:0] io_nasti_aw_bits_addr,
  input         io_nasti_w_ready,
  output        io_nasti_w_valid,
  output [63:0] io_nasti_w_bits_data,
  output        io_nasti_w_bits_last,
  output        io_nasti_b_ready,
  input         io_nasti_b_valid,
  input         io_nasti_ar_ready,
  output        io_nasti_ar_valid,
  output [31:0] io_nasti_ar_bits_addr,
  output        io_nasti_r_ready,
  input         io_nasti_r_valid,
  input  [63:0] io_nasti_r_bits_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_48;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [255:0] _RAND_52;
  reg [255:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [127:0] _RAND_61;
  reg [63:0] _RAND_62;
  reg [63:0] _RAND_63;
`endif // RANDOMIZE_REG_INIT
  reg [19:0] metaMem_tag [0:255]; // @[Cache.scala 62:29]
  wire [19:0] metaMem_tag_rmeta_data; // @[Cache.scala 62:29]
  wire [7:0] metaMem_tag_rmeta_addr; // @[Cache.scala 62:29]
  wire [19:0] metaMem_tag__T_87_data; // @[Cache.scala 62:29]
  wire [7:0] metaMem_tag__T_87_addr; // @[Cache.scala 62:29]
  wire  metaMem_tag__T_87_mask; // @[Cache.scala 62:29]
  wire  metaMem_tag__T_87_en; // @[Cache.scala 62:29]
  reg  metaMem_tag_rmeta_en_pipe_0;
  reg [7:0] metaMem_tag_rmeta_addr_pipe_0;
  reg [7:0] dataMem_0_0 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_0__T_22_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_0__T_22_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_0__T_98_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_0__T_98_addr; // @[Cache.scala 63:46]
  wire  dataMem_0_0__T_98_mask; // @[Cache.scala 63:46]
  wire  dataMem_0_0__T_98_en; // @[Cache.scala 63:46]
  reg  dataMem_0_0__T_22_en_pipe_0;
  reg [7:0] dataMem_0_0__T_22_addr_pipe_0;
  reg [7:0] dataMem_0_1 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_1__T_22_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_1__T_22_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_1__T_98_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_1__T_98_addr; // @[Cache.scala 63:46]
  wire  dataMem_0_1__T_98_mask; // @[Cache.scala 63:46]
  wire  dataMem_0_1__T_98_en; // @[Cache.scala 63:46]
  reg  dataMem_0_1__T_22_en_pipe_0;
  reg [7:0] dataMem_0_1__T_22_addr_pipe_0;
  reg [7:0] dataMem_0_2 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_2__T_22_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_2__T_22_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_2__T_98_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_2__T_98_addr; // @[Cache.scala 63:46]
  wire  dataMem_0_2__T_98_mask; // @[Cache.scala 63:46]
  wire  dataMem_0_2__T_98_en; // @[Cache.scala 63:46]
  reg  dataMem_0_2__T_22_en_pipe_0;
  reg [7:0] dataMem_0_2__T_22_addr_pipe_0;
  reg [7:0] dataMem_0_3 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_3__T_22_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_3__T_22_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_3__T_98_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_0_3__T_98_addr; // @[Cache.scala 63:46]
  wire  dataMem_0_3__T_98_mask; // @[Cache.scala 63:46]
  wire  dataMem_0_3__T_98_en; // @[Cache.scala 63:46]
  reg  dataMem_0_3__T_22_en_pipe_0;
  reg [7:0] dataMem_0_3__T_22_addr_pipe_0;
  reg [7:0] dataMem_1_0 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_0__T_29_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_0__T_29_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_0__T_109_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_0__T_109_addr; // @[Cache.scala 63:46]
  wire  dataMem_1_0__T_109_mask; // @[Cache.scala 63:46]
  wire  dataMem_1_0__T_109_en; // @[Cache.scala 63:46]
  reg  dataMem_1_0__T_29_en_pipe_0;
  reg [7:0] dataMem_1_0__T_29_addr_pipe_0;
  reg [7:0] dataMem_1_1 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_1__T_29_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_1__T_29_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_1__T_109_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_1__T_109_addr; // @[Cache.scala 63:46]
  wire  dataMem_1_1__T_109_mask; // @[Cache.scala 63:46]
  wire  dataMem_1_1__T_109_en; // @[Cache.scala 63:46]
  reg  dataMem_1_1__T_29_en_pipe_0;
  reg [7:0] dataMem_1_1__T_29_addr_pipe_0;
  reg [7:0] dataMem_1_2 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_2__T_29_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_2__T_29_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_2__T_109_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_2__T_109_addr; // @[Cache.scala 63:46]
  wire  dataMem_1_2__T_109_mask; // @[Cache.scala 63:46]
  wire  dataMem_1_2__T_109_en; // @[Cache.scala 63:46]
  reg  dataMem_1_2__T_29_en_pipe_0;
  reg [7:0] dataMem_1_2__T_29_addr_pipe_0;
  reg [7:0] dataMem_1_3 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_3__T_29_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_3__T_29_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_3__T_109_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_1_3__T_109_addr; // @[Cache.scala 63:46]
  wire  dataMem_1_3__T_109_mask; // @[Cache.scala 63:46]
  wire  dataMem_1_3__T_109_en; // @[Cache.scala 63:46]
  reg  dataMem_1_3__T_29_en_pipe_0;
  reg [7:0] dataMem_1_3__T_29_addr_pipe_0;
  reg [7:0] dataMem_2_0 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_0__T_36_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_0__T_36_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_0__T_120_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_0__T_120_addr; // @[Cache.scala 63:46]
  wire  dataMem_2_0__T_120_mask; // @[Cache.scala 63:46]
  wire  dataMem_2_0__T_120_en; // @[Cache.scala 63:46]
  reg  dataMem_2_0__T_36_en_pipe_0;
  reg [7:0] dataMem_2_0__T_36_addr_pipe_0;
  reg [7:0] dataMem_2_1 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_1__T_36_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_1__T_36_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_1__T_120_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_1__T_120_addr; // @[Cache.scala 63:46]
  wire  dataMem_2_1__T_120_mask; // @[Cache.scala 63:46]
  wire  dataMem_2_1__T_120_en; // @[Cache.scala 63:46]
  reg  dataMem_2_1__T_36_en_pipe_0;
  reg [7:0] dataMem_2_1__T_36_addr_pipe_0;
  reg [7:0] dataMem_2_2 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_2__T_36_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_2__T_36_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_2__T_120_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_2__T_120_addr; // @[Cache.scala 63:46]
  wire  dataMem_2_2__T_120_mask; // @[Cache.scala 63:46]
  wire  dataMem_2_2__T_120_en; // @[Cache.scala 63:46]
  reg  dataMem_2_2__T_36_en_pipe_0;
  reg [7:0] dataMem_2_2__T_36_addr_pipe_0;
  reg [7:0] dataMem_2_3 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_3__T_36_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_3__T_36_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_3__T_120_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_2_3__T_120_addr; // @[Cache.scala 63:46]
  wire  dataMem_2_3__T_120_mask; // @[Cache.scala 63:46]
  wire  dataMem_2_3__T_120_en; // @[Cache.scala 63:46]
  reg  dataMem_2_3__T_36_en_pipe_0;
  reg [7:0] dataMem_2_3__T_36_addr_pipe_0;
  reg [7:0] dataMem_3_0 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_0__T_43_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_0__T_43_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_0__T_131_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_0__T_131_addr; // @[Cache.scala 63:46]
  wire  dataMem_3_0__T_131_mask; // @[Cache.scala 63:46]
  wire  dataMem_3_0__T_131_en; // @[Cache.scala 63:46]
  reg  dataMem_3_0__T_43_en_pipe_0;
  reg [7:0] dataMem_3_0__T_43_addr_pipe_0;
  reg [7:0] dataMem_3_1 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_1__T_43_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_1__T_43_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_1__T_131_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_1__T_131_addr; // @[Cache.scala 63:46]
  wire  dataMem_3_1__T_131_mask; // @[Cache.scala 63:46]
  wire  dataMem_3_1__T_131_en; // @[Cache.scala 63:46]
  reg  dataMem_3_1__T_43_en_pipe_0;
  reg [7:0] dataMem_3_1__T_43_addr_pipe_0;
  reg [7:0] dataMem_3_2 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_2__T_43_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_2__T_43_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_2__T_131_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_2__T_131_addr; // @[Cache.scala 63:46]
  wire  dataMem_3_2__T_131_mask; // @[Cache.scala 63:46]
  wire  dataMem_3_2__T_131_en; // @[Cache.scala 63:46]
  reg  dataMem_3_2__T_43_en_pipe_0;
  reg [7:0] dataMem_3_2__T_43_addr_pipe_0;
  reg [7:0] dataMem_3_3 [0:255]; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_3__T_43_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_3__T_43_addr; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_3__T_131_data; // @[Cache.scala 63:46]
  wire [7:0] dataMem_3_3__T_131_addr; // @[Cache.scala 63:46]
  wire  dataMem_3_3__T_131_mask; // @[Cache.scala 63:46]
  wire  dataMem_3_3__T_131_en; // @[Cache.scala 63:46]
  reg  dataMem_3_3__T_43_en_pipe_0;
  reg [7:0] dataMem_3_3__T_43_addr_pipe_0;
  reg [2:0] state; // @[Cache.scala 58:22]
  reg [255:0] v; // @[Cache.scala 60:25]
  reg [255:0] d; // @[Cache.scala 61:25]
  reg [31:0] addr_reg; // @[Cache.scala 65:21]
  reg [31:0] cpu_data; // @[Cache.scala 66:21]
  reg [3:0] cpu_mask; // @[Cache.scala 67:21]
  wire  _T = io_nasti_r_ready & io_nasti_r_valid; // @[Decoupled.scala 40:37]
  reg  read_count; // @[Counter.scala 29:33]
  wire  _T_3 = read_count + 1'h1; // @[Counter.scala 39:22]
  wire  read_wrap_out = _T & read_count; // @[Counter.scala 67:17]
  wire  _T_4 = io_nasti_w_ready & io_nasti_w_valid; // @[Decoupled.scala 40:37]
  reg  write_count; // @[Counter.scala 29:33]
  wire  _T_7 = write_count + 1'h1; // @[Counter.scala 39:22]
  wire  write_wrap_out = _T_4 & write_count; // @[Counter.scala 67:17]
  wire  is_idle = state == 3'h0; // @[Cache.scala 74:25]
  wire  is_read = state == 3'h1; // @[Cache.scala 75:25]
  wire  is_write = state == 3'h2; // @[Cache.scala 76:25]
  wire  _T_8 = state == 3'h6; // @[Cache.scala 77:25]
  wire  is_alloc = _T_8 & read_wrap_out; // @[Cache.scala 77:38]
  reg  is_alloc_reg; // @[Cache.scala 78:29]
  wire [7:0] idx_reg = addr_reg[11:4]; // @[Cache.scala 88:26]
  wire [255:0] _T_51 = v >> idx_reg; // @[Cache.scala 97:11]
  wire [19:0] tag_reg = addr_reg[31:12]; // @[Cache.scala 87:26]
  wire  _T_53 = metaMem_tag_rmeta_data == tag_reg; // @[Cache.scala 97:34]
  wire  hit = _T_51[0] & _T_53; // @[Cache.scala 97:21]
  wire  _T_9 = hit | is_alloc_reg; // @[Cache.scala 81:30]
  wire  _T_10 = is_write & _T_9; // @[Cache.scala 81:22]
  wire  _T_11 = ~io_cpu_abort; // @[Cache.scala 81:50]
  wire  _T_12 = _T_10 & _T_11; // @[Cache.scala 81:47]
  wire  wen = _T_12 | is_alloc; // @[Cache.scala 81:64]
  wire  _T_13 = ~wen; // @[Cache.scala 82:13]
  wire  _T_14 = is_idle | is_read; // @[Cache.scala 82:30]
  wire  _T_15 = _T_13 & _T_14; // @[Cache.scala 82:18]
  reg  ren_reg; // @[Cache.scala 83:24]
  wire [1:0] off_reg = addr_reg[3:2]; // @[Cache.scala 89:26]
  wire [63:0] _T_47 = {dataMem_1_3__T_29_data,dataMem_1_2__T_29_data,dataMem_1_1__T_29_data,dataMem_1_0__T_29_data,dataMem_0_3__T_22_data,dataMem_0_2__T_22_data,dataMem_0_1__T_22_data,dataMem_0_0__T_22_data}; // @[Cat.scala 30:58]
  wire [127:0] rdata = {dataMem_3_3__T_43_data,dataMem_3_2__T_43_data,dataMem_3_1__T_43_data,dataMem_3_0__T_43_data,dataMem_2_3__T_36_data,dataMem_2_2__T_36_data,dataMem_2_1__T_36_data,dataMem_2_0__T_36_data,_T_47}; // @[Cat.scala 30:58]
  reg [127:0] rdata_buf; // @[Reg.scala 15:16]
  wire [127:0] _GEN_12 = ren_reg ? rdata : rdata_buf; // @[Reg.scala 16:19]
  reg [63:0] refill_buf_0; // @[Cache.scala 94:23]
  reg [63:0] refill_buf_1; // @[Cache.scala 94:23]
  wire [127:0] _T_49 = {refill_buf_1,refill_buf_0}; // @[Cache.scala 95:43]
  wire [127:0] read = is_alloc_reg ? _T_49 : _GEN_12; // @[Cache.scala 95:17]
  wire [31:0] _GEN_14 = 2'h1 == off_reg ? read[63:32] : read[31:0]; // @[Cache.scala 100:25]
  wire [31:0] _GEN_15 = 2'h2 == off_reg ? read[95:64] : _GEN_14; // @[Cache.scala 100:25]
  wire  _T_60 = is_read & hit; // @[Cache.scala 101:47]
  wire  _T_61 = is_idle | _T_60; // @[Cache.scala 101:36]
  wire  _T_62 = |cpu_mask; // @[Cache.scala 101:83]
  wire  _T_63 = ~_T_62; // @[Cache.scala 101:73]
  wire  _T_64 = is_alloc_reg & _T_63; // @[Cache.scala 101:70]
  wire  _T_66 = ~is_alloc; // @[Cache.scala 112:19]
  wire [3:0] _T_67 = {off_reg,2'h0}; // @[Cat.scala 30:58]
  wire [18:0] _GEN_146 = {{15'd0}, cpu_mask}; // @[Cache.scala 112:40]
  wire [18:0] _T_68 = _GEN_146 << _T_67; // @[Cache.scala 112:40]
  wire [19:0] _T_69 = {1'b0,$signed(_T_68)}; // @[Cache.scala 112:80]
  wire [19:0] wmask = _T_66 ? $signed(_T_69) : $signed(-20'sh1); // @[Cache.scala 112:18]
  wire [127:0] _T_72 = {cpu_data,cpu_data,cpu_data,cpu_data}; // @[Cat.scala 30:58]
  wire [127:0] _T_73 = {io_nasti_r_bits_data,refill_buf_0}; // @[Cat.scala 30:58]
  wire [127:0] wdata = _T_66 ? _T_72 : _T_73; // @[Cache.scala 113:18]
  wire [255:0] _T_74 = 256'h1 << idx_reg; // @[Cache.scala 117:18]
  wire [255:0] _T_75 = v | _T_74; // @[Cache.scala 117:18]
  wire [255:0] _T_82 = d | _T_74; // @[Cache.scala 118:18]
  wire [255:0] _T_83 = ~d; // @[Cache.scala 118:18]
  wire [255:0] _T_84 = _T_83 | _T_74; // @[Cache.scala 118:18]
  wire [255:0] _T_85 = ~_T_84; // @[Cache.scala 118:18]
  wire [27:0] _T_132 = {tag_reg,idx_reg}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_147 = {_T_132, 4'h0}; // @[Cache.scala 130:33]
  wire [34:0] _T_133 = {{3'd0}, _GEN_147}; // @[Cache.scala 130:33]
  wire [27:0] _T_139 = {metaMem_tag_rmeta_data,idx_reg}; // @[Cat.scala 30:58]
  wire [31:0] _GEN_148 = {_T_139, 4'h0}; // @[Cache.scala 138:35]
  wire [34:0] _T_140 = {{3'd0}, _GEN_148}; // @[Cache.scala 138:35]
  wire [255:0] _T_151 = d >> idx_reg; // @[Cache.scala 149:33]
  wire  is_dirty = _T_51[0] & _T_151[0]; // @[Cache.scala 149:29]
  wire  _T_153 = 3'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_154 = |io_cpu_req_bits_mask; // @[Cache.scala 153:43]
  wire  _T_156 = 3'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_159 = ~is_dirty; // @[Cache.scala 165:30]
  wire  _T_160 = io_nasti_aw_ready & io_nasti_aw_valid; // @[Decoupled.scala 40:37]
  wire  _T_161 = io_nasti_ar_ready & io_nasti_ar_valid; // @[Decoupled.scala 40:37]
  wire  _GEN_110 = hit ? 1'h0 : is_dirty; // @[Cache.scala 157:17]
  wire  _GEN_111 = hit ? 1'h0 : _T_159; // @[Cache.scala 157:17]
  wire  _T_162 = 3'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_164 = _T_9 | io_cpu_abort; // @[Cache.scala 174:32]
  wire  _GEN_115 = _T_164 ? 1'h0 : is_dirty; // @[Cache.scala 174:49]
  wire  _GEN_116 = _T_164 ? 1'h0 : _T_159; // @[Cache.scala 174:49]
  wire  _T_168 = 3'h3 == state; // @[Conditional.scala 37:30]
  wire  _T_169 = 3'h4 == state; // @[Conditional.scala 37:30]
  wire  _T_170 = io_nasti_b_ready & io_nasti_b_valid; // @[Decoupled.scala 40:37]
  wire  _T_171 = 3'h5 == state; // @[Conditional.scala 37:30]
  wire  _T_173 = 3'h6 == state; // @[Conditional.scala 37:30]
  wire  _GEN_126 = _T_169 ? 1'h0 : _T_171; // @[Conditional.scala 39:67]
  wire  _GEN_129 = _T_168 ? 1'h0 : _T_169; // @[Conditional.scala 39:67]
  wire  _GEN_130 = _T_168 ? 1'h0 : _GEN_126; // @[Conditional.scala 39:67]
  wire  _GEN_132 = _T_162 & _GEN_115; // @[Conditional.scala 39:67]
  wire  _GEN_133 = _T_162 ? _GEN_116 : _GEN_130; // @[Conditional.scala 39:67]
  wire  _GEN_134 = _T_162 ? 1'h0 : _T_168; // @[Conditional.scala 39:67]
  wire  _GEN_135 = _T_162 ? 1'h0 : _GEN_129; // @[Conditional.scala 39:67]
  wire  _GEN_137 = _T_156 ? _GEN_110 : _GEN_132; // @[Conditional.scala 39:67]
  wire  _GEN_138 = _T_156 ? _GEN_111 : _GEN_133; // @[Conditional.scala 39:67]
  wire  _GEN_139 = _T_156 ? 1'h0 : _GEN_134; // @[Conditional.scala 39:67]
  wire  _GEN_140 = _T_156 ? 1'h0 : _GEN_135; // @[Conditional.scala 39:67]
  assign metaMem_tag_rmeta_addr = metaMem_tag_rmeta_addr_pipe_0;
  assign metaMem_tag_rmeta_data = metaMem_tag[metaMem_tag_rmeta_addr]; // @[Cache.scala 62:29]
  assign metaMem_tag__T_87_data = addr_reg[31:12];
  assign metaMem_tag__T_87_addr = addr_reg[11:4];
  assign metaMem_tag__T_87_mask = 1'h1;
  assign metaMem_tag__T_87_en = wen & is_alloc;
  assign dataMem_0_0__T_22_addr = dataMem_0_0__T_22_addr_pipe_0;
  assign dataMem_0_0__T_22_data = dataMem_0_0[dataMem_0_0__T_22_addr]; // @[Cache.scala 63:46]
  assign dataMem_0_0__T_98_data = wdata[7:0];
  assign dataMem_0_0__T_98_addr = addr_reg[11:4];
  assign dataMem_0_0__T_98_mask = wmask[0];
  assign dataMem_0_0__T_98_en = _T_12 | is_alloc;
  assign dataMem_0_1__T_22_addr = dataMem_0_1__T_22_addr_pipe_0;
  assign dataMem_0_1__T_22_data = dataMem_0_1[dataMem_0_1__T_22_addr]; // @[Cache.scala 63:46]
  assign dataMem_0_1__T_98_data = wdata[15:8];
  assign dataMem_0_1__T_98_addr = addr_reg[11:4];
  assign dataMem_0_1__T_98_mask = wmask[1];
  assign dataMem_0_1__T_98_en = _T_12 | is_alloc;
  assign dataMem_0_2__T_22_addr = dataMem_0_2__T_22_addr_pipe_0;
  assign dataMem_0_2__T_22_data = dataMem_0_2[dataMem_0_2__T_22_addr]; // @[Cache.scala 63:46]
  assign dataMem_0_2__T_98_data = wdata[23:16];
  assign dataMem_0_2__T_98_addr = addr_reg[11:4];
  assign dataMem_0_2__T_98_mask = wmask[2];
  assign dataMem_0_2__T_98_en = _T_12 | is_alloc;
  assign dataMem_0_3__T_22_addr = dataMem_0_3__T_22_addr_pipe_0;
  assign dataMem_0_3__T_22_data = dataMem_0_3[dataMem_0_3__T_22_addr]; // @[Cache.scala 63:46]
  assign dataMem_0_3__T_98_data = wdata[31:24];
  assign dataMem_0_3__T_98_addr = addr_reg[11:4];
  assign dataMem_0_3__T_98_mask = wmask[3];
  assign dataMem_0_3__T_98_en = _T_12 | is_alloc;
  assign dataMem_1_0__T_29_addr = dataMem_1_0__T_29_addr_pipe_0;
  assign dataMem_1_0__T_29_data = dataMem_1_0[dataMem_1_0__T_29_addr]; // @[Cache.scala 63:46]
  assign dataMem_1_0__T_109_data = wdata[39:32];
  assign dataMem_1_0__T_109_addr = addr_reg[11:4];
  assign dataMem_1_0__T_109_mask = wmask[4];
  assign dataMem_1_0__T_109_en = _T_12 | is_alloc;
  assign dataMem_1_1__T_29_addr = dataMem_1_1__T_29_addr_pipe_0;
  assign dataMem_1_1__T_29_data = dataMem_1_1[dataMem_1_1__T_29_addr]; // @[Cache.scala 63:46]
  assign dataMem_1_1__T_109_data = wdata[47:40];
  assign dataMem_1_1__T_109_addr = addr_reg[11:4];
  assign dataMem_1_1__T_109_mask = wmask[5];
  assign dataMem_1_1__T_109_en = _T_12 | is_alloc;
  assign dataMem_1_2__T_29_addr = dataMem_1_2__T_29_addr_pipe_0;
  assign dataMem_1_2__T_29_data = dataMem_1_2[dataMem_1_2__T_29_addr]; // @[Cache.scala 63:46]
  assign dataMem_1_2__T_109_data = wdata[55:48];
  assign dataMem_1_2__T_109_addr = addr_reg[11:4];
  assign dataMem_1_2__T_109_mask = wmask[6];
  assign dataMem_1_2__T_109_en = _T_12 | is_alloc;
  assign dataMem_1_3__T_29_addr = dataMem_1_3__T_29_addr_pipe_0;
  assign dataMem_1_3__T_29_data = dataMem_1_3[dataMem_1_3__T_29_addr]; // @[Cache.scala 63:46]
  assign dataMem_1_3__T_109_data = wdata[63:56];
  assign dataMem_1_3__T_109_addr = addr_reg[11:4];
  assign dataMem_1_3__T_109_mask = wmask[7];
  assign dataMem_1_3__T_109_en = _T_12 | is_alloc;
  assign dataMem_2_0__T_36_addr = dataMem_2_0__T_36_addr_pipe_0;
  assign dataMem_2_0__T_36_data = dataMem_2_0[dataMem_2_0__T_36_addr]; // @[Cache.scala 63:46]
  assign dataMem_2_0__T_120_data = wdata[71:64];
  assign dataMem_2_0__T_120_addr = addr_reg[11:4];
  assign dataMem_2_0__T_120_mask = wmask[8];
  assign dataMem_2_0__T_120_en = _T_12 | is_alloc;
  assign dataMem_2_1__T_36_addr = dataMem_2_1__T_36_addr_pipe_0;
  assign dataMem_2_1__T_36_data = dataMem_2_1[dataMem_2_1__T_36_addr]; // @[Cache.scala 63:46]
  assign dataMem_2_1__T_120_data = wdata[79:72];
  assign dataMem_2_1__T_120_addr = addr_reg[11:4];
  assign dataMem_2_1__T_120_mask = wmask[9];
  assign dataMem_2_1__T_120_en = _T_12 | is_alloc;
  assign dataMem_2_2__T_36_addr = dataMem_2_2__T_36_addr_pipe_0;
  assign dataMem_2_2__T_36_data = dataMem_2_2[dataMem_2_2__T_36_addr]; // @[Cache.scala 63:46]
  assign dataMem_2_2__T_120_data = wdata[87:80];
  assign dataMem_2_2__T_120_addr = addr_reg[11:4];
  assign dataMem_2_2__T_120_mask = wmask[10];
  assign dataMem_2_2__T_120_en = _T_12 | is_alloc;
  assign dataMem_2_3__T_36_addr = dataMem_2_3__T_36_addr_pipe_0;
  assign dataMem_2_3__T_36_data = dataMem_2_3[dataMem_2_3__T_36_addr]; // @[Cache.scala 63:46]
  assign dataMem_2_3__T_120_data = wdata[95:88];
  assign dataMem_2_3__T_120_addr = addr_reg[11:4];
  assign dataMem_2_3__T_120_mask = wmask[11];
  assign dataMem_2_3__T_120_en = _T_12 | is_alloc;
  assign dataMem_3_0__T_43_addr = dataMem_3_0__T_43_addr_pipe_0;
  assign dataMem_3_0__T_43_data = dataMem_3_0[dataMem_3_0__T_43_addr]; // @[Cache.scala 63:46]
  assign dataMem_3_0__T_131_data = wdata[103:96];
  assign dataMem_3_0__T_131_addr = addr_reg[11:4];
  assign dataMem_3_0__T_131_mask = wmask[12];
  assign dataMem_3_0__T_131_en = _T_12 | is_alloc;
  assign dataMem_3_1__T_43_addr = dataMem_3_1__T_43_addr_pipe_0;
  assign dataMem_3_1__T_43_data = dataMem_3_1[dataMem_3_1__T_43_addr]; // @[Cache.scala 63:46]
  assign dataMem_3_1__T_131_data = wdata[111:104];
  assign dataMem_3_1__T_131_addr = addr_reg[11:4];
  assign dataMem_3_1__T_131_mask = wmask[13];
  assign dataMem_3_1__T_131_en = _T_12 | is_alloc;
  assign dataMem_3_2__T_43_addr = dataMem_3_2__T_43_addr_pipe_0;
  assign dataMem_3_2__T_43_data = dataMem_3_2[dataMem_3_2__T_43_addr]; // @[Cache.scala 63:46]
  assign dataMem_3_2__T_131_data = wdata[119:112];
  assign dataMem_3_2__T_131_addr = addr_reg[11:4];
  assign dataMem_3_2__T_131_mask = wmask[14];
  assign dataMem_3_2__T_131_en = _T_12 | is_alloc;
  assign dataMem_3_3__T_43_addr = dataMem_3_3__T_43_addr_pipe_0;
  assign dataMem_3_3__T_43_data = dataMem_3_3[dataMem_3_3__T_43_addr]; // @[Cache.scala 63:46]
  assign dataMem_3_3__T_131_data = wdata[127:120];
  assign dataMem_3_3__T_131_addr = addr_reg[11:4];
  assign dataMem_3_3__T_131_mask = wmask[15];
  assign dataMem_3_3__T_131_en = _T_12 | is_alloc;
  assign io_cpu_resp_valid = _T_61 | _T_64; // @[Cache.scala 101:25]
  assign io_cpu_resp_bits_data = 2'h3 == off_reg ? read[127:96] : _GEN_15; // @[Cache.scala 100:25]
  assign io_nasti_aw_valid = _T_153 ? 1'h0 : _GEN_137; // @[Cache.scala 139:21 Cache.scala 164:27 Cache.scala 177:27]
  assign io_nasti_aw_bits_addr = _T_140[31:0]; // @[Cache.scala 137:20]
  assign io_nasti_w_valid = _T_153 ? 1'h0 : _GEN_139; // @[Cache.scala 144:20 Cache.scala 187:24]
  assign io_nasti_w_bits_data = write_count ? read[127:64] : read[63:0]; // @[Cache.scala 141:19]
  assign io_nasti_w_bits_last = _T_4 & write_count; // @[Cache.scala 141:19]
  assign io_nasti_b_ready = _T_153 ? 1'h0 : _GEN_140; // @[Cache.scala 146:20 Cache.scala 193:24]
  assign io_nasti_ar_valid = _T_153 ? 1'h0 : _GEN_138; // @[Cache.scala 131:21 Cache.scala 165:27 Cache.scala 178:27 Cache.scala 199:25]
  assign io_nasti_ar_bits_addr = _T_133[31:0]; // @[Cache.scala 129:20]
  assign io_nasti_r_ready = state == 3'h6; // @[Cache.scala 133:20]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    metaMem_tag[initvar] = _RAND_0[19:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_0_0[initvar] = _RAND_3[7:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_0_1[initvar] = _RAND_6[7:0];
  _RAND_9 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_0_2[initvar] = _RAND_9[7:0];
  _RAND_12 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_0_3[initvar] = _RAND_12[7:0];
  _RAND_15 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_1_0[initvar] = _RAND_15[7:0];
  _RAND_18 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_1_1[initvar] = _RAND_18[7:0];
  _RAND_21 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_1_2[initvar] = _RAND_21[7:0];
  _RAND_24 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_1_3[initvar] = _RAND_24[7:0];
  _RAND_27 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_2_0[initvar] = _RAND_27[7:0];
  _RAND_30 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_2_1[initvar] = _RAND_30[7:0];
  _RAND_33 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_2_2[initvar] = _RAND_33[7:0];
  _RAND_36 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_2_3[initvar] = _RAND_36[7:0];
  _RAND_39 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_3_0[initvar] = _RAND_39[7:0];
  _RAND_42 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_3_1[initvar] = _RAND_42[7:0];
  _RAND_45 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_3_2[initvar] = _RAND_45[7:0];
  _RAND_48 = {1{`RANDOM}};
  for (initvar = 0; initvar < 256; initvar = initvar+1)
    dataMem_3_3[initvar] = _RAND_48[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  metaMem_tag_rmeta_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  metaMem_tag_rmeta_addr_pipe_0 = _RAND_2[7:0];
  _RAND_4 = {1{`RANDOM}};
  dataMem_0_0__T_22_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  dataMem_0_0__T_22_addr_pipe_0 = _RAND_5[7:0];
  _RAND_7 = {1{`RANDOM}};
  dataMem_0_1__T_22_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  dataMem_0_1__T_22_addr_pipe_0 = _RAND_8[7:0];
  _RAND_10 = {1{`RANDOM}};
  dataMem_0_2__T_22_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  dataMem_0_2__T_22_addr_pipe_0 = _RAND_11[7:0];
  _RAND_13 = {1{`RANDOM}};
  dataMem_0_3__T_22_en_pipe_0 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  dataMem_0_3__T_22_addr_pipe_0 = _RAND_14[7:0];
  _RAND_16 = {1{`RANDOM}};
  dataMem_1_0__T_29_en_pipe_0 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  dataMem_1_0__T_29_addr_pipe_0 = _RAND_17[7:0];
  _RAND_19 = {1{`RANDOM}};
  dataMem_1_1__T_29_en_pipe_0 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  dataMem_1_1__T_29_addr_pipe_0 = _RAND_20[7:0];
  _RAND_22 = {1{`RANDOM}};
  dataMem_1_2__T_29_en_pipe_0 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  dataMem_1_2__T_29_addr_pipe_0 = _RAND_23[7:0];
  _RAND_25 = {1{`RANDOM}};
  dataMem_1_3__T_29_en_pipe_0 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  dataMem_1_3__T_29_addr_pipe_0 = _RAND_26[7:0];
  _RAND_28 = {1{`RANDOM}};
  dataMem_2_0__T_36_en_pipe_0 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  dataMem_2_0__T_36_addr_pipe_0 = _RAND_29[7:0];
  _RAND_31 = {1{`RANDOM}};
  dataMem_2_1__T_36_en_pipe_0 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  dataMem_2_1__T_36_addr_pipe_0 = _RAND_32[7:0];
  _RAND_34 = {1{`RANDOM}};
  dataMem_2_2__T_36_en_pipe_0 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  dataMem_2_2__T_36_addr_pipe_0 = _RAND_35[7:0];
  _RAND_37 = {1{`RANDOM}};
  dataMem_2_3__T_36_en_pipe_0 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  dataMem_2_3__T_36_addr_pipe_0 = _RAND_38[7:0];
  _RAND_40 = {1{`RANDOM}};
  dataMem_3_0__T_43_en_pipe_0 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  dataMem_3_0__T_43_addr_pipe_0 = _RAND_41[7:0];
  _RAND_43 = {1{`RANDOM}};
  dataMem_3_1__T_43_en_pipe_0 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  dataMem_3_1__T_43_addr_pipe_0 = _RAND_44[7:0];
  _RAND_46 = {1{`RANDOM}};
  dataMem_3_2__T_43_en_pipe_0 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  dataMem_3_2__T_43_addr_pipe_0 = _RAND_47[7:0];
  _RAND_49 = {1{`RANDOM}};
  dataMem_3_3__T_43_en_pipe_0 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  dataMem_3_3__T_43_addr_pipe_0 = _RAND_50[7:0];
  _RAND_51 = {1{`RANDOM}};
  state = _RAND_51[2:0];
  _RAND_52 = {8{`RANDOM}};
  v = _RAND_52[255:0];
  _RAND_53 = {8{`RANDOM}};
  d = _RAND_53[255:0];
  _RAND_54 = {1{`RANDOM}};
  addr_reg = _RAND_54[31:0];
  _RAND_55 = {1{`RANDOM}};
  cpu_data = _RAND_55[31:0];
  _RAND_56 = {1{`RANDOM}};
  cpu_mask = _RAND_56[3:0];
  _RAND_57 = {1{`RANDOM}};
  read_count = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  write_count = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  is_alloc_reg = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  ren_reg = _RAND_60[0:0];
  _RAND_61 = {4{`RANDOM}};
  rdata_buf = _RAND_61[127:0];
  _RAND_62 = {2{`RANDOM}};
  refill_buf_0 = _RAND_62[63:0];
  _RAND_63 = {2{`RANDOM}};
  refill_buf_1 = _RAND_63[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(metaMem_tag__T_87_en & metaMem_tag__T_87_mask) begin
      metaMem_tag[metaMem_tag__T_87_addr] <= metaMem_tag__T_87_data; // @[Cache.scala 62:29]
    end
    metaMem_tag_rmeta_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      metaMem_tag_rmeta_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_0_0__T_98_en & dataMem_0_0__T_98_mask) begin
      dataMem_0_0[dataMem_0_0__T_98_addr] <= dataMem_0_0__T_98_data; // @[Cache.scala 63:46]
    end
    dataMem_0_0__T_22_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_0_0__T_22_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_0_1__T_98_en & dataMem_0_1__T_98_mask) begin
      dataMem_0_1[dataMem_0_1__T_98_addr] <= dataMem_0_1__T_98_data; // @[Cache.scala 63:46]
    end
    dataMem_0_1__T_22_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_0_1__T_22_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_0_2__T_98_en & dataMem_0_2__T_98_mask) begin
      dataMem_0_2[dataMem_0_2__T_98_addr] <= dataMem_0_2__T_98_data; // @[Cache.scala 63:46]
    end
    dataMem_0_2__T_22_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_0_2__T_22_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_0_3__T_98_en & dataMem_0_3__T_98_mask) begin
      dataMem_0_3[dataMem_0_3__T_98_addr] <= dataMem_0_3__T_98_data; // @[Cache.scala 63:46]
    end
    dataMem_0_3__T_22_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_0_3__T_22_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_1_0__T_109_en & dataMem_1_0__T_109_mask) begin
      dataMem_1_0[dataMem_1_0__T_109_addr] <= dataMem_1_0__T_109_data; // @[Cache.scala 63:46]
    end
    dataMem_1_0__T_29_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_1_0__T_29_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_1_1__T_109_en & dataMem_1_1__T_109_mask) begin
      dataMem_1_1[dataMem_1_1__T_109_addr] <= dataMem_1_1__T_109_data; // @[Cache.scala 63:46]
    end
    dataMem_1_1__T_29_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_1_1__T_29_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_1_2__T_109_en & dataMem_1_2__T_109_mask) begin
      dataMem_1_2[dataMem_1_2__T_109_addr] <= dataMem_1_2__T_109_data; // @[Cache.scala 63:46]
    end
    dataMem_1_2__T_29_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_1_2__T_29_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_1_3__T_109_en & dataMem_1_3__T_109_mask) begin
      dataMem_1_3[dataMem_1_3__T_109_addr] <= dataMem_1_3__T_109_data; // @[Cache.scala 63:46]
    end
    dataMem_1_3__T_29_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_1_3__T_29_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_2_0__T_120_en & dataMem_2_0__T_120_mask) begin
      dataMem_2_0[dataMem_2_0__T_120_addr] <= dataMem_2_0__T_120_data; // @[Cache.scala 63:46]
    end
    dataMem_2_0__T_36_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_2_0__T_36_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_2_1__T_120_en & dataMem_2_1__T_120_mask) begin
      dataMem_2_1[dataMem_2_1__T_120_addr] <= dataMem_2_1__T_120_data; // @[Cache.scala 63:46]
    end
    dataMem_2_1__T_36_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_2_1__T_36_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_2_2__T_120_en & dataMem_2_2__T_120_mask) begin
      dataMem_2_2[dataMem_2_2__T_120_addr] <= dataMem_2_2__T_120_data; // @[Cache.scala 63:46]
    end
    dataMem_2_2__T_36_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_2_2__T_36_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_2_3__T_120_en & dataMem_2_3__T_120_mask) begin
      dataMem_2_3[dataMem_2_3__T_120_addr] <= dataMem_2_3__T_120_data; // @[Cache.scala 63:46]
    end
    dataMem_2_3__T_36_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_2_3__T_36_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_3_0__T_131_en & dataMem_3_0__T_131_mask) begin
      dataMem_3_0[dataMem_3_0__T_131_addr] <= dataMem_3_0__T_131_data; // @[Cache.scala 63:46]
    end
    dataMem_3_0__T_43_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_3_0__T_43_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_3_1__T_131_en & dataMem_3_1__T_131_mask) begin
      dataMem_3_1[dataMem_3_1__T_131_addr] <= dataMem_3_1__T_131_data; // @[Cache.scala 63:46]
    end
    dataMem_3_1__T_43_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_3_1__T_43_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_3_2__T_131_en & dataMem_3_2__T_131_mask) begin
      dataMem_3_2[dataMem_3_2__T_131_addr] <= dataMem_3_2__T_131_data; // @[Cache.scala 63:46]
    end
    dataMem_3_2__T_43_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_3_2__T_43_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if(dataMem_3_3__T_131_en & dataMem_3_3__T_131_mask) begin
      dataMem_3_3[dataMem_3_3__T_131_addr] <= dataMem_3_3__T_131_data; // @[Cache.scala 63:46]
    end
    dataMem_3_3__T_43_en_pipe_0 <= _T_15 & io_cpu_req_valid;
    if (_T_15 & io_cpu_req_valid) begin
      dataMem_3_3__T_43_addr_pipe_0 <= io_cpu_req_bits_addr[11:4];
    end
    if (reset) begin
      state <= 3'h0;
    end else if (_T_153) begin
      if (io_cpu_req_valid) begin
        if (_T_154) begin
          state <= 3'h2;
        end else begin
          state <= 3'h1;
        end
      end
    end else if (_T_156) begin
      if (hit) begin
        if (io_cpu_req_valid) begin
          if (_T_154) begin
            state <= 3'h2;
          end else begin
            state <= 3'h1;
          end
        end else begin
          state <= 3'h0;
        end
      end else if (_T_160) begin
        state <= 3'h3;
      end else if (_T_161) begin
        state <= 3'h6;
      end
    end else if (_T_162) begin
      if (_T_164) begin
        state <= 3'h0;
      end else if (_T_160) begin
        state <= 3'h3;
      end else if (_T_161) begin
        state <= 3'h6;
      end
    end else if (_T_168) begin
      if (write_wrap_out) begin
        state <= 3'h4;
      end
    end else if (_T_169) begin
      if (_T_170) begin
        state <= 3'h5;
      end
    end else if (_T_171) begin
      if (_T_161) begin
        state <= 3'h6;
      end
    end else if (_T_173) begin
      if (read_wrap_out) begin
        if (_T_62) begin
          state <= 3'h2;
        end else begin
          state <= 3'h0;
        end
      end
    end
    if (reset) begin
      v <= 256'h0;
    end else if (wen) begin
      v <= _T_75;
    end
    if (reset) begin
      d <= 256'h0;
    end else if (wen) begin
      if (_T_66) begin
        d <= _T_82;
      end else begin
        d <= _T_85;
      end
    end
    if (io_cpu_resp_valid) begin
      addr_reg <= io_cpu_req_bits_addr;
    end
    if (io_cpu_resp_valid) begin
      cpu_data <= io_cpu_req_bits_data;
    end
    if (io_cpu_resp_valid) begin
      cpu_mask <= io_cpu_req_bits_mask;
    end
    if (reset) begin
      read_count <= 1'h0;
    end else if (_T) begin
      read_count <= _T_3;
    end
    if (reset) begin
      write_count <= 1'h0;
    end else if (_T_4) begin
      write_count <= _T_7;
    end
    is_alloc_reg <= _T_8 & read_wrap_out;
    ren_reg <= _T_15 & io_cpu_req_valid;
    if (ren_reg) begin
      rdata_buf <= rdata;
    end
    if (_T) begin
      if (~read_count) begin
        refill_buf_0 <= io_nasti_r_bits_data;
      end
    end
    if (_T) begin
      if (read_count) begin
        refill_buf_1 <= io_nasti_r_bits_data;
      end
    end
  end
endmodule
module MemArbiter(
  input         clock,
  input         reset,
  output        io_icache_ar_ready,
  input         io_icache_ar_valid,
  input  [31:0] io_icache_ar_bits_addr,
  input         io_icache_r_ready,
  output        io_icache_r_valid,
  output [63:0] io_icache_r_bits_data,
  output        io_dcache_aw_ready,
  input         io_dcache_aw_valid,
  input  [31:0] io_dcache_aw_bits_addr,
  output        io_dcache_w_ready,
  input         io_dcache_w_valid,
  input  [63:0] io_dcache_w_bits_data,
  input         io_dcache_w_bits_last,
  input         io_dcache_b_ready,
  output        io_dcache_b_valid,
  output        io_dcache_ar_ready,
  input         io_dcache_ar_valid,
  input  [31:0] io_dcache_ar_bits_addr,
  input         io_dcache_r_ready,
  output        io_dcache_r_valid,
  output [63:0] io_dcache_r_bits_data,
  input         io_nasti_aw_ready,
  output        io_nasti_aw_valid,
  output [31:0] io_nasti_aw_bits_addr,
  input         io_nasti_w_ready,
  output        io_nasti_w_valid,
  output [63:0] io_nasti_w_bits_data,
  output        io_nasti_w_bits_last,
  output        io_nasti_b_ready,
  input         io_nasti_b_valid,
  input         io_nasti_ar_ready,
  output        io_nasti_ar_valid,
  output [31:0] io_nasti_ar_bits_addr,
  output        io_nasti_r_ready,
  input         io_nasti_r_valid,
  input  [63:0] io_nasti_r_bits_data,
  input         io_nasti_r_bits_last
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] state; // @[Tile.scala 21:22]
  wire  _T = state == 3'h0; // @[Tile.scala 25:52]
  wire  _T_4 = state == 3'h3; // @[Tile.scala 31:50]
  wire  _T_8 = state == 3'h4; // @[Tile.scala 37:50]
  wire  _T_19 = io_icache_ar_valid | io_dcache_ar_valid; // @[Tile.scala 47:44]
  wire  _T_20 = ~io_nasti_aw_valid; // @[Tile.scala 48:5]
  wire  _T_21 = _T_19 & _T_20; // @[Tile.scala 47:67]
  wire  _T_25 = io_nasti_ar_ready & _T_20; // @[Tile.scala 49:43]
  wire  _T_28 = ~io_dcache_ar_valid; // @[Tile.scala 50:47]
  wire  _T_30 = state == 3'h1; // @[Tile.scala 55:50]
  wire  _T_32 = state == 3'h2; // @[Tile.scala 56:50]
  wire  _T_35 = io_icache_r_ready & _T_30; // @[Tile.scala 57:41]
  wire  _T_37 = io_dcache_r_ready & _T_32; // @[Tile.scala 58:41]
  wire  _T_39 = 3'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_40 = io_dcache_aw_ready & io_dcache_aw_valid; // @[Decoupled.scala 40:37]
  wire  _T_41 = io_dcache_ar_ready & io_dcache_ar_valid; // @[Decoupled.scala 40:37]
  wire  _T_42 = io_icache_ar_ready & io_icache_ar_valid; // @[Decoupled.scala 40:37]
  wire  _T_43 = 3'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_44 = io_nasti_r_ready & io_nasti_r_valid; // @[Decoupled.scala 40:37]
  wire  _T_45 = _T_44 & io_nasti_r_bits_last; // @[Tile.scala 71:30]
  wire  _T_46 = 3'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_49 = 3'h3 == state; // @[Conditional.scala 37:30]
  wire  _T_50 = io_dcache_w_ready & io_dcache_w_valid; // @[Decoupled.scala 40:37]
  wire  _T_51 = _T_50 & io_dcache_w_bits_last; // @[Tile.scala 81:31]
  wire  _T_52 = 3'h4 == state; // @[Conditional.scala 37:30]
  wire  _T_53 = io_nasti_b_ready & io_nasti_b_valid; // @[Decoupled.scala 40:37]
  assign io_icache_ar_ready = io_dcache_ar_ready & _T_28; // @[Tile.scala 50:22]
  assign io_icache_r_valid = io_nasti_r_valid & _T_30; // @[Tile.scala 55:21]
  assign io_icache_r_bits_data = io_nasti_r_bits_data; // @[Tile.scala 53:21]
  assign io_dcache_aw_ready = io_nasti_aw_ready & _T; // @[Tile.scala 26:22]
  assign io_dcache_w_ready = io_nasti_w_ready & _T_4; // @[Tile.scala 32:21]
  assign io_dcache_b_valid = io_nasti_b_valid & _T_8; // @[Tile.scala 37:21]
  assign io_dcache_ar_ready = _T_25 & _T; // @[Tile.scala 49:22]
  assign io_dcache_r_valid = io_nasti_r_valid & _T_32; // @[Tile.scala 56:21]
  assign io_dcache_r_bits_data = io_nasti_r_bits_data; // @[Tile.scala 54:21]
  assign io_nasti_aw_valid = io_dcache_aw_valid & _T; // @[Tile.scala 25:21]
  assign io_nasti_aw_bits_addr = io_dcache_aw_bits_addr; // @[Tile.scala 24:20]
  assign io_nasti_w_valid = io_dcache_w_valid & _T_4; // @[Tile.scala 31:20]
  assign io_nasti_w_bits_data = io_dcache_w_bits_data; // @[Tile.scala 30:20]
  assign io_nasti_w_bits_last = io_dcache_w_bits_last; // @[Tile.scala 30:20]
  assign io_nasti_b_ready = io_dcache_b_ready & _T_8; // @[Tile.scala 38:20]
  assign io_nasti_ar_valid = _T_21 & _T; // @[Tile.scala 47:21]
  assign io_nasti_ar_bits_addr = io_dcache_ar_valid ? io_dcache_ar_bits_addr : io_icache_ar_bits_addr; // @[Tile.scala 42:20]
  assign io_nasti_r_ready = _T_35 | _T_37; // @[Tile.scala 57:20]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      state <= 3'h0;
    end else if (_T_39) begin
      if (_T_40) begin
        state <= 3'h3;
      end else if (_T_41) begin
        state <= 3'h2;
      end else if (_T_42) begin
        state <= 3'h1;
      end
    end else if (_T_43) begin
      if (_T_45) begin
        state <= 3'h0;
      end
    end else if (_T_46) begin
      if (_T_45) begin
        state <= 3'h0;
      end
    end else if (_T_49) begin
      if (_T_51) begin
        state <= 3'h4;
      end
    end else if (_T_52) begin
      if (_T_53) begin
        state <= 3'h0;
      end
    end
  end
endmodule
module Tile(
  input         clock,
  input         reset,
  input         io_host_fromhost_valid,
  input  [31:0] io_host_fromhost_bits,
  output [31:0] io_host_tohost,
  input         io_nasti_aw_ready,
  output        io_nasti_aw_valid,
  output [31:0] io_nasti_aw_bits_addr,
  output [7:0]  io_nasti_aw_bits_len,
  output [2:0]  io_nasti_aw_bits_size,
  output [1:0]  io_nasti_aw_bits_burst,
  output        io_nasti_aw_bits_lock,
  output [3:0]  io_nasti_aw_bits_cache,
  output [2:0]  io_nasti_aw_bits_prot,
  output [3:0]  io_nasti_aw_bits_qos,
  output [3:0]  io_nasti_aw_bits_region,
  output [4:0]  io_nasti_aw_bits_id,
  output        io_nasti_aw_bits_user,
  input         io_nasti_w_ready,
  output        io_nasti_w_valid,
  output [63:0] io_nasti_w_bits_data,
  output        io_nasti_w_bits_last,
  output [4:0]  io_nasti_w_bits_id,
  output [7:0]  io_nasti_w_bits_strb,
  output        io_nasti_w_bits_user,
  output        io_nasti_b_ready,
  input         io_nasti_b_valid,
  input  [1:0]  io_nasti_b_bits_resp,
  input  [4:0]  io_nasti_b_bits_id,
  input         io_nasti_b_bits_user,
  input         io_nasti_ar_ready,
  output        io_nasti_ar_valid,
  output [31:0] io_nasti_ar_bits_addr,
  output [7:0]  io_nasti_ar_bits_len,
  output [2:0]  io_nasti_ar_bits_size,
  output [1:0]  io_nasti_ar_bits_burst,
  output        io_nasti_ar_bits_lock,
  output [3:0]  io_nasti_ar_bits_cache,
  output [2:0]  io_nasti_ar_bits_prot,
  output [3:0]  io_nasti_ar_bits_qos,
  output [3:0]  io_nasti_ar_bits_region,
  output [4:0]  io_nasti_ar_bits_id,
  output        io_nasti_ar_bits_user,
  output        io_nasti_r_ready,
  input         io_nasti_r_valid,
  input  [1:0]  io_nasti_r_bits_resp,
  input  [63:0] io_nasti_r_bits_data,
  input         io_nasti_r_bits_last,
  input  [4:0]  io_nasti_r_bits_id,
  input         io_nasti_r_bits_user
);
  wire  core_clock; // @[Tile.scala 107:22]
  wire  core_reset; // @[Tile.scala 107:22]
  wire  core_io_host_fromhost_valid; // @[Tile.scala 107:22]
  wire [31:0] core_io_host_fromhost_bits; // @[Tile.scala 107:22]
  wire [31:0] core_io_host_tohost; // @[Tile.scala 107:22]
  wire  core_io_icache_req_valid; // @[Tile.scala 107:22]
  wire [31:0] core_io_icache_req_bits_addr; // @[Tile.scala 107:22]
  wire  core_io_icache_resp_valid; // @[Tile.scala 107:22]
  wire [31:0] core_io_icache_resp_bits_data; // @[Tile.scala 107:22]
  wire  core_io_dcache_abort; // @[Tile.scala 107:22]
  wire  core_io_dcache_req_valid; // @[Tile.scala 107:22]
  wire [31:0] core_io_dcache_req_bits_addr; // @[Tile.scala 107:22]
  wire [31:0] core_io_dcache_req_bits_data; // @[Tile.scala 107:22]
  wire [3:0] core_io_dcache_req_bits_mask; // @[Tile.scala 107:22]
  wire  core_io_dcache_resp_valid; // @[Tile.scala 107:22]
  wire [31:0] core_io_dcache_resp_bits_data; // @[Tile.scala 107:22]
  wire  icache_clock; // @[Tile.scala 108:22]
  wire  icache_reset; // @[Tile.scala 108:22]
  wire  icache_io_cpu_abort; // @[Tile.scala 108:22]
  wire  icache_io_cpu_req_valid; // @[Tile.scala 108:22]
  wire [31:0] icache_io_cpu_req_bits_addr; // @[Tile.scala 108:22]
  wire [31:0] icache_io_cpu_req_bits_data; // @[Tile.scala 108:22]
  wire [3:0] icache_io_cpu_req_bits_mask; // @[Tile.scala 108:22]
  wire  icache_io_cpu_resp_valid; // @[Tile.scala 108:22]
  wire [31:0] icache_io_cpu_resp_bits_data; // @[Tile.scala 108:22]
  wire  icache_io_nasti_aw_ready; // @[Tile.scala 108:22]
  wire  icache_io_nasti_aw_valid; // @[Tile.scala 108:22]
  wire [31:0] icache_io_nasti_aw_bits_addr; // @[Tile.scala 108:22]
  wire  icache_io_nasti_w_ready; // @[Tile.scala 108:22]
  wire  icache_io_nasti_w_valid; // @[Tile.scala 108:22]
  wire [63:0] icache_io_nasti_w_bits_data; // @[Tile.scala 108:22]
  wire  icache_io_nasti_w_bits_last; // @[Tile.scala 108:22]
  wire  icache_io_nasti_b_ready; // @[Tile.scala 108:22]
  wire  icache_io_nasti_b_valid; // @[Tile.scala 108:22]
  wire  icache_io_nasti_ar_ready; // @[Tile.scala 108:22]
  wire  icache_io_nasti_ar_valid; // @[Tile.scala 108:22]
  wire [31:0] icache_io_nasti_ar_bits_addr; // @[Tile.scala 108:22]
  wire  icache_io_nasti_r_ready; // @[Tile.scala 108:22]
  wire  icache_io_nasti_r_valid; // @[Tile.scala 108:22]
  wire [63:0] icache_io_nasti_r_bits_data; // @[Tile.scala 108:22]
  wire  dcache_clock; // @[Tile.scala 109:22]
  wire  dcache_reset; // @[Tile.scala 109:22]
  wire  dcache_io_cpu_abort; // @[Tile.scala 109:22]
  wire  dcache_io_cpu_req_valid; // @[Tile.scala 109:22]
  wire [31:0] dcache_io_cpu_req_bits_addr; // @[Tile.scala 109:22]
  wire [31:0] dcache_io_cpu_req_bits_data; // @[Tile.scala 109:22]
  wire [3:0] dcache_io_cpu_req_bits_mask; // @[Tile.scala 109:22]
  wire  dcache_io_cpu_resp_valid; // @[Tile.scala 109:22]
  wire [31:0] dcache_io_cpu_resp_bits_data; // @[Tile.scala 109:22]
  wire  dcache_io_nasti_aw_ready; // @[Tile.scala 109:22]
  wire  dcache_io_nasti_aw_valid; // @[Tile.scala 109:22]
  wire [31:0] dcache_io_nasti_aw_bits_addr; // @[Tile.scala 109:22]
  wire  dcache_io_nasti_w_ready; // @[Tile.scala 109:22]
  wire  dcache_io_nasti_w_valid; // @[Tile.scala 109:22]
  wire [63:0] dcache_io_nasti_w_bits_data; // @[Tile.scala 109:22]
  wire  dcache_io_nasti_w_bits_last; // @[Tile.scala 109:22]
  wire  dcache_io_nasti_b_ready; // @[Tile.scala 109:22]
  wire  dcache_io_nasti_b_valid; // @[Tile.scala 109:22]
  wire  dcache_io_nasti_ar_ready; // @[Tile.scala 109:22]
  wire  dcache_io_nasti_ar_valid; // @[Tile.scala 109:22]
  wire [31:0] dcache_io_nasti_ar_bits_addr; // @[Tile.scala 109:22]
  wire  dcache_io_nasti_r_ready; // @[Tile.scala 109:22]
  wire  dcache_io_nasti_r_valid; // @[Tile.scala 109:22]
  wire [63:0] dcache_io_nasti_r_bits_data; // @[Tile.scala 109:22]
  wire  arb_clock; // @[Tile.scala 110:22]
  wire  arb_reset; // @[Tile.scala 110:22]
  wire  arb_io_icache_ar_ready; // @[Tile.scala 110:22]
  wire  arb_io_icache_ar_valid; // @[Tile.scala 110:22]
  wire [31:0] arb_io_icache_ar_bits_addr; // @[Tile.scala 110:22]
  wire  arb_io_icache_r_ready; // @[Tile.scala 110:22]
  wire  arb_io_icache_r_valid; // @[Tile.scala 110:22]
  wire [63:0] arb_io_icache_r_bits_data; // @[Tile.scala 110:22]
  wire  arb_io_dcache_aw_ready; // @[Tile.scala 110:22]
  wire  arb_io_dcache_aw_valid; // @[Tile.scala 110:22]
  wire [31:0] arb_io_dcache_aw_bits_addr; // @[Tile.scala 110:22]
  wire  arb_io_dcache_w_ready; // @[Tile.scala 110:22]
  wire  arb_io_dcache_w_valid; // @[Tile.scala 110:22]
  wire [63:0] arb_io_dcache_w_bits_data; // @[Tile.scala 110:22]
  wire  arb_io_dcache_w_bits_last; // @[Tile.scala 110:22]
  wire  arb_io_dcache_b_ready; // @[Tile.scala 110:22]
  wire  arb_io_dcache_b_valid; // @[Tile.scala 110:22]
  wire  arb_io_dcache_ar_ready; // @[Tile.scala 110:22]
  wire  arb_io_dcache_ar_valid; // @[Tile.scala 110:22]
  wire [31:0] arb_io_dcache_ar_bits_addr; // @[Tile.scala 110:22]
  wire  arb_io_dcache_r_ready; // @[Tile.scala 110:22]
  wire  arb_io_dcache_r_valid; // @[Tile.scala 110:22]
  wire [63:0] arb_io_dcache_r_bits_data; // @[Tile.scala 110:22]
  wire  arb_io_nasti_aw_ready; // @[Tile.scala 110:22]
  wire  arb_io_nasti_aw_valid; // @[Tile.scala 110:22]
  wire [31:0] arb_io_nasti_aw_bits_addr; // @[Tile.scala 110:22]
  wire  arb_io_nasti_w_ready; // @[Tile.scala 110:22]
  wire  arb_io_nasti_w_valid; // @[Tile.scala 110:22]
  wire [63:0] arb_io_nasti_w_bits_data; // @[Tile.scala 110:22]
  wire  arb_io_nasti_w_bits_last; // @[Tile.scala 110:22]
  wire  arb_io_nasti_b_ready; // @[Tile.scala 110:22]
  wire  arb_io_nasti_b_valid; // @[Tile.scala 110:22]
  wire  arb_io_nasti_ar_ready; // @[Tile.scala 110:22]
  wire  arb_io_nasti_ar_valid; // @[Tile.scala 110:22]
  wire [31:0] arb_io_nasti_ar_bits_addr; // @[Tile.scala 110:22]
  wire  arb_io_nasti_r_ready; // @[Tile.scala 110:22]
  wire  arb_io_nasti_r_valid; // @[Tile.scala 110:22]
  wire [63:0] arb_io_nasti_r_bits_data; // @[Tile.scala 110:22]
  wire  arb_io_nasti_r_bits_last; // @[Tile.scala 110:22]
  Core core ( // @[Tile.scala 107:22]
    .clock(core_clock),
    .reset(core_reset),
    .io_host_fromhost_valid(core_io_host_fromhost_valid),
    .io_host_fromhost_bits(core_io_host_fromhost_bits),
    .io_host_tohost(core_io_host_tohost),
    .io_icache_req_valid(core_io_icache_req_valid),
    .io_icache_req_bits_addr(core_io_icache_req_bits_addr),
    .io_icache_resp_valid(core_io_icache_resp_valid),
    .io_icache_resp_bits_data(core_io_icache_resp_bits_data),
    .io_dcache_abort(core_io_dcache_abort),
    .io_dcache_req_valid(core_io_dcache_req_valid),
    .io_dcache_req_bits_addr(core_io_dcache_req_bits_addr),
    .io_dcache_req_bits_data(core_io_dcache_req_bits_data),
    .io_dcache_req_bits_mask(core_io_dcache_req_bits_mask),
    .io_dcache_resp_valid(core_io_dcache_resp_valid),
    .io_dcache_resp_bits_data(core_io_dcache_resp_bits_data)
  );
  Cache icache ( // @[Tile.scala 108:22]
    .clock(icache_clock),
    .reset(icache_reset),
    .io_cpu_abort(icache_io_cpu_abort),
    .io_cpu_req_valid(icache_io_cpu_req_valid),
    .io_cpu_req_bits_addr(icache_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(icache_io_cpu_req_bits_data),
    .io_cpu_req_bits_mask(icache_io_cpu_req_bits_mask),
    .io_cpu_resp_valid(icache_io_cpu_resp_valid),
    .io_cpu_resp_bits_data(icache_io_cpu_resp_bits_data),
    .io_nasti_aw_ready(icache_io_nasti_aw_ready),
    .io_nasti_aw_valid(icache_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(icache_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(icache_io_nasti_w_ready),
    .io_nasti_w_valid(icache_io_nasti_w_valid),
    .io_nasti_w_bits_data(icache_io_nasti_w_bits_data),
    .io_nasti_w_bits_last(icache_io_nasti_w_bits_last),
    .io_nasti_b_ready(icache_io_nasti_b_ready),
    .io_nasti_b_valid(icache_io_nasti_b_valid),
    .io_nasti_ar_ready(icache_io_nasti_ar_ready),
    .io_nasti_ar_valid(icache_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(icache_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(icache_io_nasti_r_ready),
    .io_nasti_r_valid(icache_io_nasti_r_valid),
    .io_nasti_r_bits_data(icache_io_nasti_r_bits_data)
  );
  Cache dcache ( // @[Tile.scala 109:22]
    .clock(dcache_clock),
    .reset(dcache_reset),
    .io_cpu_abort(dcache_io_cpu_abort),
    .io_cpu_req_valid(dcache_io_cpu_req_valid),
    .io_cpu_req_bits_addr(dcache_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(dcache_io_cpu_req_bits_data),
    .io_cpu_req_bits_mask(dcache_io_cpu_req_bits_mask),
    .io_cpu_resp_valid(dcache_io_cpu_resp_valid),
    .io_cpu_resp_bits_data(dcache_io_cpu_resp_bits_data),
    .io_nasti_aw_ready(dcache_io_nasti_aw_ready),
    .io_nasti_aw_valid(dcache_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(dcache_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(dcache_io_nasti_w_ready),
    .io_nasti_w_valid(dcache_io_nasti_w_valid),
    .io_nasti_w_bits_data(dcache_io_nasti_w_bits_data),
    .io_nasti_w_bits_last(dcache_io_nasti_w_bits_last),
    .io_nasti_b_ready(dcache_io_nasti_b_ready),
    .io_nasti_b_valid(dcache_io_nasti_b_valid),
    .io_nasti_ar_ready(dcache_io_nasti_ar_ready),
    .io_nasti_ar_valid(dcache_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(dcache_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(dcache_io_nasti_r_ready),
    .io_nasti_r_valid(dcache_io_nasti_r_valid),
    .io_nasti_r_bits_data(dcache_io_nasti_r_bits_data)
  );
  MemArbiter arb ( // @[Tile.scala 110:22]
    .clock(arb_clock),
    .reset(arb_reset),
    .io_icache_ar_ready(arb_io_icache_ar_ready),
    .io_icache_ar_valid(arb_io_icache_ar_valid),
    .io_icache_ar_bits_addr(arb_io_icache_ar_bits_addr),
    .io_icache_r_ready(arb_io_icache_r_ready),
    .io_icache_r_valid(arb_io_icache_r_valid),
    .io_icache_r_bits_data(arb_io_icache_r_bits_data),
    .io_dcache_aw_ready(arb_io_dcache_aw_ready),
    .io_dcache_aw_valid(arb_io_dcache_aw_valid),
    .io_dcache_aw_bits_addr(arb_io_dcache_aw_bits_addr),
    .io_dcache_w_ready(arb_io_dcache_w_ready),
    .io_dcache_w_valid(arb_io_dcache_w_valid),
    .io_dcache_w_bits_data(arb_io_dcache_w_bits_data),
    .io_dcache_w_bits_last(arb_io_dcache_w_bits_last),
    .io_dcache_b_ready(arb_io_dcache_b_ready),
    .io_dcache_b_valid(arb_io_dcache_b_valid),
    .io_dcache_ar_ready(arb_io_dcache_ar_ready),
    .io_dcache_ar_valid(arb_io_dcache_ar_valid),
    .io_dcache_ar_bits_addr(arb_io_dcache_ar_bits_addr),
    .io_dcache_r_ready(arb_io_dcache_r_ready),
    .io_dcache_r_valid(arb_io_dcache_r_valid),
    .io_dcache_r_bits_data(arb_io_dcache_r_bits_data),
    .io_nasti_aw_ready(arb_io_nasti_aw_ready),
    .io_nasti_aw_valid(arb_io_nasti_aw_valid),
    .io_nasti_aw_bits_addr(arb_io_nasti_aw_bits_addr),
    .io_nasti_w_ready(arb_io_nasti_w_ready),
    .io_nasti_w_valid(arb_io_nasti_w_valid),
    .io_nasti_w_bits_data(arb_io_nasti_w_bits_data),
    .io_nasti_w_bits_last(arb_io_nasti_w_bits_last),
    .io_nasti_b_ready(arb_io_nasti_b_ready),
    .io_nasti_b_valid(arb_io_nasti_b_valid),
    .io_nasti_ar_ready(arb_io_nasti_ar_ready),
    .io_nasti_ar_valid(arb_io_nasti_ar_valid),
    .io_nasti_ar_bits_addr(arb_io_nasti_ar_bits_addr),
    .io_nasti_r_ready(arb_io_nasti_r_ready),
    .io_nasti_r_valid(arb_io_nasti_r_valid),
    .io_nasti_r_bits_data(arb_io_nasti_r_bits_data),
    .io_nasti_r_bits_last(arb_io_nasti_r_bits_last)
  );
  assign io_host_tohost = core_io_host_tohost; // @[Tile.scala 112:11]
  assign io_nasti_aw_valid = arb_io_nasti_aw_valid; // @[Tile.scala 117:12]
  assign io_nasti_aw_bits_addr = arb_io_nasti_aw_bits_addr; // @[Tile.scala 117:12]
  assign io_nasti_aw_bits_len = 8'h1; // @[Tile.scala 117:12]
  assign io_nasti_aw_bits_size = 3'h3; // @[Tile.scala 117:12]
  assign io_nasti_aw_bits_burst = 2'h1; // @[Tile.scala 117:12]
  assign io_nasti_aw_bits_lock = 1'h0; // @[Tile.scala 117:12]
  assign io_nasti_aw_bits_cache = 4'h0; // @[Tile.scala 117:12]
  assign io_nasti_aw_bits_prot = 3'h0; // @[Tile.scala 117:12]
  assign io_nasti_aw_bits_qos = 4'h0; // @[Tile.scala 117:12]
  assign io_nasti_aw_bits_region = 4'h0; // @[Tile.scala 117:12]
  assign io_nasti_aw_bits_id = 5'h0; // @[Tile.scala 117:12]
  assign io_nasti_aw_bits_user = 1'h0; // @[Tile.scala 117:12]
  assign io_nasti_w_valid = arb_io_nasti_w_valid; // @[Tile.scala 117:12]
  assign io_nasti_w_bits_data = arb_io_nasti_w_bits_data; // @[Tile.scala 117:12]
  assign io_nasti_w_bits_last = arb_io_nasti_w_bits_last; // @[Tile.scala 117:12]
  assign io_nasti_w_bits_id = 5'h0; // @[Tile.scala 117:12]
  assign io_nasti_w_bits_strb = 8'hff; // @[Tile.scala 117:12]
  assign io_nasti_w_bits_user = 1'h0; // @[Tile.scala 117:12]
  assign io_nasti_b_ready = arb_io_nasti_b_ready; // @[Tile.scala 117:12]
  assign io_nasti_ar_valid = arb_io_nasti_ar_valid; // @[Tile.scala 117:12]
  assign io_nasti_ar_bits_addr = arb_io_nasti_ar_bits_addr; // @[Tile.scala 117:12]
  assign io_nasti_ar_bits_len = 8'h1; // @[Tile.scala 117:12]
  assign io_nasti_ar_bits_size = 3'h3; // @[Tile.scala 117:12]
  assign io_nasti_ar_bits_burst = 2'h1; // @[Tile.scala 117:12]
  assign io_nasti_ar_bits_lock = 1'h0; // @[Tile.scala 117:12]
  assign io_nasti_ar_bits_cache = 4'h0; // @[Tile.scala 117:12]
  assign io_nasti_ar_bits_prot = 3'h0; // @[Tile.scala 117:12]
  assign io_nasti_ar_bits_qos = 4'h0; // @[Tile.scala 117:12]
  assign io_nasti_ar_bits_region = 4'h0; // @[Tile.scala 117:12]
  assign io_nasti_ar_bits_id = 5'h0; // @[Tile.scala 117:12]
  assign io_nasti_ar_bits_user = 1'h0; // @[Tile.scala 117:12]
  assign io_nasti_r_ready = arb_io_nasti_r_ready; // @[Tile.scala 117:12]
  assign core_clock = clock;
  assign core_reset = reset;
  assign core_io_host_fromhost_valid = io_host_fromhost_valid; // @[Tile.scala 112:11]
  assign core_io_host_fromhost_bits = io_host_fromhost_bits; // @[Tile.scala 112:11]
  assign core_io_icache_resp_valid = icache_io_cpu_resp_valid; // @[Tile.scala 113:18]
  assign core_io_icache_resp_bits_data = icache_io_cpu_resp_bits_data; // @[Tile.scala 113:18]
  assign core_io_dcache_resp_valid = dcache_io_cpu_resp_valid; // @[Tile.scala 114:18]
  assign core_io_dcache_resp_bits_data = dcache_io_cpu_resp_bits_data; // @[Tile.scala 114:18]
  assign icache_clock = clock;
  assign icache_reset = reset;
  assign icache_io_cpu_abort = 1'h0; // @[Tile.scala 113:18]
  assign icache_io_cpu_req_valid = core_io_icache_req_valid; // @[Tile.scala 113:18]
  assign icache_io_cpu_req_bits_addr = core_io_icache_req_bits_addr; // @[Tile.scala 113:18]
  assign icache_io_cpu_req_bits_data = 32'h0; // @[Tile.scala 113:18]
  assign icache_io_cpu_req_bits_mask = 4'h0; // @[Tile.scala 113:18]
  assign icache_io_nasti_aw_ready = 1'h0; // @[Tile.scala 115:17]
  assign icache_io_nasti_w_ready = 1'h0; // @[Tile.scala 115:17]
  assign icache_io_nasti_b_valid = 1'h0; // @[Tile.scala 115:17]
  assign icache_io_nasti_ar_ready = arb_io_icache_ar_ready; // @[Tile.scala 115:17]
  assign icache_io_nasti_r_valid = arb_io_icache_r_valid; // @[Tile.scala 115:17]
  assign icache_io_nasti_r_bits_data = arb_io_icache_r_bits_data; // @[Tile.scala 115:17]
  assign dcache_clock = clock;
  assign dcache_reset = reset;
  assign dcache_io_cpu_abort = core_io_dcache_abort; // @[Tile.scala 114:18]
  assign dcache_io_cpu_req_valid = core_io_dcache_req_valid; // @[Tile.scala 114:18]
  assign dcache_io_cpu_req_bits_addr = core_io_dcache_req_bits_addr; // @[Tile.scala 114:18]
  assign dcache_io_cpu_req_bits_data = core_io_dcache_req_bits_data; // @[Tile.scala 114:18]
  assign dcache_io_cpu_req_bits_mask = core_io_dcache_req_bits_mask; // @[Tile.scala 114:18]
  assign dcache_io_nasti_aw_ready = arb_io_dcache_aw_ready; // @[Tile.scala 116:17]
  assign dcache_io_nasti_w_ready = arb_io_dcache_w_ready; // @[Tile.scala 116:17]
  assign dcache_io_nasti_b_valid = arb_io_dcache_b_valid; // @[Tile.scala 116:17]
  assign dcache_io_nasti_ar_ready = arb_io_dcache_ar_ready; // @[Tile.scala 116:17]
  assign dcache_io_nasti_r_valid = arb_io_dcache_r_valid; // @[Tile.scala 116:17]
  assign dcache_io_nasti_r_bits_data = arb_io_dcache_r_bits_data; // @[Tile.scala 116:17]
  assign arb_clock = clock;
  assign arb_reset = reset;
  assign arb_io_icache_ar_valid = icache_io_nasti_ar_valid; // @[Tile.scala 115:17]
  assign arb_io_icache_ar_bits_addr = icache_io_nasti_ar_bits_addr; // @[Tile.scala 115:17]
  assign arb_io_icache_r_ready = icache_io_nasti_r_ready; // @[Tile.scala 115:17]
  assign arb_io_dcache_aw_valid = dcache_io_nasti_aw_valid; // @[Tile.scala 116:17]
  assign arb_io_dcache_aw_bits_addr = dcache_io_nasti_aw_bits_addr; // @[Tile.scala 116:17]
  assign arb_io_dcache_w_valid = dcache_io_nasti_w_valid; // @[Tile.scala 116:17]
  assign arb_io_dcache_w_bits_data = dcache_io_nasti_w_bits_data; // @[Tile.scala 116:17]
  assign arb_io_dcache_w_bits_last = dcache_io_nasti_w_bits_last; // @[Tile.scala 116:17]
  assign arb_io_dcache_b_ready = dcache_io_nasti_b_ready; // @[Tile.scala 116:17]
  assign arb_io_dcache_ar_valid = dcache_io_nasti_ar_valid; // @[Tile.scala 116:17]
  assign arb_io_dcache_ar_bits_addr = dcache_io_nasti_ar_bits_addr; // @[Tile.scala 116:17]
  assign arb_io_dcache_r_ready = dcache_io_nasti_r_ready; // @[Tile.scala 116:17]
  assign arb_io_nasti_aw_ready = io_nasti_aw_ready; // @[Tile.scala 117:12]
  assign arb_io_nasti_w_ready = io_nasti_w_ready; // @[Tile.scala 117:12]
  assign arb_io_nasti_b_valid = io_nasti_b_valid; // @[Tile.scala 117:12]
  assign arb_io_nasti_ar_ready = io_nasti_ar_ready; // @[Tile.scala 117:12]
  assign arb_io_nasti_r_valid = io_nasti_r_valid; // @[Tile.scala 117:12]
  assign arb_io_nasti_r_bits_data = io_nasti_r_bits_data; // @[Tile.scala 117:12]
  assign arb_io_nasti_r_bits_last = io_nasti_r_bits_last; // @[Tile.scala 117:12]
endmodule
