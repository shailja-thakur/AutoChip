module top_module (
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out
);

    // Assigning values to next_state[A]
    assign next_state[0] = (in == 0) ? (state[0] | state[2]) : 0;
    
    // Assigning values to next_state[B]
    assign next_state[1] = (in == 0) ? 0 : (state[0] | state[1] | state[3]);

    // Assigning values to next_state[C]
    assign next_state[2] = (in == 0) ? (state[1] | state[3]) : 0;

    // Assigning values to next_state[D]
    assign next_state[3] = (in == 0) ? 0 : state[2];
    
    // Assigning out to state[D]
    assign out = state[3];

endmodule
