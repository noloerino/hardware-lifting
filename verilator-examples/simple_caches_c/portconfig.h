#define ADD_INPUT(inputname) std::cin >> input; top->inputname = input;
#define ADD_PRINT_PORT(portname) VL_PRINTF(" [" #portname "=%x]", top->portname); 

// Define this if the output is piped as oracle interface
// #define SMO
// In that case redefine this to match the required interface
#define ADD_SMO_PRINTING_STMTS ADD_DEBUG_PRINTING_STMTS 

// Configure inputs
#define ADD_SET_INPUTS \
	ADD_INPUT(wraddress) \
	ADD_INPUT(wren) \
	ADD_INPUT(data) \
	ADD_INPUT(rdaddress)

// Configure DEBUGPRINT
#define ADD_DEBUG_PRINTING_STMTS \
	ADD_PRINT_PORT(wraddress) \
	ADD_PRINT_PORT(wren) \
	ADD_PRINT_PORT(data) \
	ADD_PRINT_PORT(rdaddress) \
	ADD_PRINT_PORT(q)
