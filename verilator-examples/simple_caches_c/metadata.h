#define ADD_INPUT(inputname) std::cin >> input; top->inputname = input;
#define ADD_PRINT_PORT(portname) VL_PRINTF(" [" #portname "=%x]", top->portname); 

#define SMO 0

#define ADD_SET_INPUTS \
	ADD_INPUT(wraddress) \
	ADD_INPUT(wren) \
	ADD_INPUT(data) \
	ADD_INPUT(rdaddress)

#define ADD_PRINTING_STMTS \
	ADD_PRINT_PORT(wraddress) \
	ADD_PRINT_PORT(wren) \
	ADD_PRINT_PORT(data) \
	ADD_PRINT_PORT(rdaddress) \
	ADD_PRINT_PORT(q)
