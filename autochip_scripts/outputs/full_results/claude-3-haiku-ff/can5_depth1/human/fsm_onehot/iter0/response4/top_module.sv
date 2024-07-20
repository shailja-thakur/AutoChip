module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2
);

wire s0, s1, s2, s3, s4, s5, s6, s7, s8, s9;
assign s0 = state[0];
assign s1 = state[1];
assign s2 = state[2];
assign s3 = state[3];
assign s4 = state[4];
assign s5 = state[5];
assign s6 = state[6];
assign s7 = state[7];
assign s8 = state[8];
assign s9 = state[9];

// Next state logic
assign next_state[0] = (s0 & ~in) | (s1 & ~in) | (s2 & ~in) | (s3 & ~in) | (s4 & ~in) | (s8 & ~in);
assign next_state[1] = (s0 & in) | (s8 & in);
assign next_state[2] = (s1 & in);
assign next_state[3] = (s2 & in);
assign next_state[4] = (s3 & in);
assign next_state[5] = (s4 & in) | (s6 & ~in);
assign next_state[6] = (s5 & in) | (s6 & in);
assign next_state[7] = (s6 & in) | (s7 & in);
assign next_state[8] = (s5 & ~in) | (s8 & in);
assign next_state[9] = (s6 & ~in);

// Output logic
assign out1 = s8 | s9;
assign out2 = s7 | s9;

endmodule
