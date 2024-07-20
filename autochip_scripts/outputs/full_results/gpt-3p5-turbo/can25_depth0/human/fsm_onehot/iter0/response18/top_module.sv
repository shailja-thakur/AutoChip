module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
    
    // Output wires for each state
    wire [9:0] next_state;
    wire out1, out2;
    
    // State transition logic
    assign next_state[0] = state[0] & ~in | state[3] | state[4] | state[5];
    assign next_state[1] = state[0] & in | state[1] | state[7];
    assign next_state[2] = state[0] & in | state[2] | state[6];
    assign next_state[3] = state[1] & ~in;
    assign next_state[4] = state[2] & ~in;
    assign next_state[5] = state[3] & ~in;
    assign next_state[6] = state[4] & ~in | state[9];
    assign next_state[7] = state[5] & ~in | state[8];
    assign next_state[8] = state[6] & ~in;
    assign next_state[9] = state[7] & ~in | state[1] & in;
    
    // Output logic
    assign out1 = state[6] | state[9];
    assign out2 = state[7];
    
endmodule
