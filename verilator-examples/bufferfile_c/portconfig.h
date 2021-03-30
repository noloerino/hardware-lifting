#define ADD_INPUT(inputname) top->inputname = atoi(argv[2*curr_cycle+offset]); offset++;
#define ADD_PRINT_PORT(portname) VL_PRINTF(" [" #portname "=%x]", top->portname); 

#define ADD_PRINT_SMO(portname) VL_PRINTF("(_ bv%d 8) ", top->portname);

#define CYCLE_CNT 2

// Define this if the output is piped as oracle interface
#define SMO
// 3 5 4 6 3 7 4 8 4 9
// In that case redefine this to match the required interface
#define ADD_SMO_PRINTING_STMTS \
	ADD_PRINT_SMO(oup)	 

// Configure inputs
#define ADD_SET_INPUTS \
	ADD_INPUT(addr) \
	ADD_INPUT(inp)

// Configure DEBUGPRINT
#define ADD_DEBUG_PRINTING_STMTS \
	ADD_PRINT_PORT(addr) \
	ADD_PRINT_PORT(inp) \
	ADD_PRINT_PORT(oup)


// if (!(ss >> clinp)) {
// 	std::cerr << "Unable to parse: " << argv[2*curr_cycle+1] << '\n';
// } else {
// 	top->addr = clinp;
// }
