module top_module (
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out
);

    // Assign next_state[A]
    assign next_state[0] = (in == 1'b0) ? (state[0] | state[2]) : 1'b0;

    // Assign next_state[B]
    assign next_state[1] = (in == 1'b0) ? 1'b0 : (state[0] | state[1] | state[3]);

    // Assign next_state[C]
    assign next_state[2] = (in == 1'b0) ? (state[1] | state[3]) : 1'b0;

    // Assign next_state[D]
    assign next_state[3] = (in == 1'b0) ? 1'b0 : state[2];

    // Assign out
    assign out = state[3];
    
endmodule
