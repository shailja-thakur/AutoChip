module top_module (
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out
);

    // First assign statement
    assign next_state[0] = in ? 1'b0 : (state[0] | state[2]);

    // Second assign statement
    assign next_state[1] = in ? (state[0] | state[1] | state[3]) : 1'b0;

    // Third assign statement
    assign next_state[2] = in ? 1'b0 : (state[1] | state[3]);

    // Fourth assign statement
    assign next_state[3] = in ? state[2] : 1'b0;

    // Assign out port
    assign out = state[3];

endmodule
