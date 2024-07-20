module top_module (
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out
);

assign next_state[0] = in ? 0 : (state[0] | state[2]);
assign next_state[1] = in ? (state[0] | state[1] | state[3]) : 0;
assign next_state[2] = in ? 0 : (state[1] | state[3]);
assign next_state[3] = in ? state[2] : 0;
assign out = state[3];

endmodule
