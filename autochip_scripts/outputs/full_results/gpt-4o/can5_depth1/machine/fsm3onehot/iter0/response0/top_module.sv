module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // assign statements for next_state[A], next_state[B], next_state[C], and next_state[D]
    assign next_state[0] = (~in) ? (state[0] | state[2]) : 1'b0; // next_state[A]
    assign next_state[1] = (in) ? (state[0] | state[1] | state[3]) : 1'b0; // next_state[B]
    assign next_state[2] = (~in) ? (state[1] | state[3]) : 1'b0; // next_state[C]
    assign next_state[3] = (in) ? state[2] : 1'b0; // next_state[D]

    // assign statement for out port
    assign out = state[3]; // out

endmodule
