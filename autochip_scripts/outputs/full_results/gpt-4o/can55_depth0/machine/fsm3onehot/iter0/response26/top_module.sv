module top_module (
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out
);

    // Assign statements for the next state logic
    assign next_state[0] = (in == 1'b0) ? (state[0] | state[2]) : 1'b0; // next_state[A]
    assign next_state[1] = (in == 1'b0) ? 1'b0 : (state[0] | state[1] | state[3]); // next_state[B]
    assign next_state[2] = (in == 1'b0) ? (state[1] | state[3]) : 1'b0; // next_state[C]
    assign next_state[3] = (in == 1'b0) ? 1'b0 : state[2]; // next_state[D]

    // Assign statement for the output logic
    assign out = state[3]; // out depends on state[D]

endmodule
