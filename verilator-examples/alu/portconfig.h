#define ADD_INPUT(inputname) top->inputname = atoi(argv[2*curr_cycle+offset]); offset++;
#define ADD_PRINT_PORT(portname) VL_PRINTF(" [" #portname "=%x]", top->portname); 

#define ADD_PRINT_SMO(portname) VL_PRINTF("(_ bv%d 32) ", top->portname);

#define CYCLE_CNT 1 

// Define this if the output is piped as oracle interface
#define SMO
// In that case redefine this to match the required interface
#define ADD_SMO_PRINTING_STMTS \
    ADD_PRINT_SMO(io_out)

// Configure inputs
#define ADD_SET_INPUTS \
    ADD_INPUT(io_A) \
    ADD_INPUT(io_B) \
    ADD_INPUT(io_alu_op)

// Configure DEBUGPRINT
#define ADD_DEBUG_PRINTING_STMTS \
    ADD_PRINT_PORT(io_A) \
    ADD_PRINT_PORT(io_B) \
    ADD_PRINT_PORT(io_alu_op)
