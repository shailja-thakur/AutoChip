module top_module (
	input in,
	input [3:0] state,
	output [3:0] next_state,
	output out
);

	assign next_state[0] = in ? 0 : state[0] | state[2];      // next_state[A]
	assign next_state[1] = in ? (state[0] | state[1] | state[3]) : 0; // next_state[B]
	assign next_state[2] = in ? 0 : state[1] | state[3];      // next_state[C]
	assign next_state[3] = in ? state[2] : 0;                 // next_state[D]
	assign out = state[3];                                    // out

endmodule
