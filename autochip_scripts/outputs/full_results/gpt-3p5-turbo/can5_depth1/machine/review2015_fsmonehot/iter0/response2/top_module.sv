module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );
	
	// Internal signals
	wire S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;

	assign S = state[0];
	assign S1 = state[1];
	assign S11 = state[2];
	assign S110 = state[3];
	assign B0 = state[4];
	assign B1 = state[5];
	assign B2 = state[6];
	assign B3 = state[7];
	assign Count = state[8];
	assign Wait = state[9];

	// Outputs
	assign counting = (Count == 1);
	assign shift_ena = (B0 || B1 || B2 || B3);
	assign B3_next = (B2 == 1);
	assign S_next = ((S && !d) || (S1 && !d) || (S110 && !d) || (Wait && ack));
	assign S1_next = (S && d);
	assign Count_next = (B3 || (Count && !done_counting));
	assign Wait_next = ((Count && done_counting) || (Wait && !ack));
	assign done = (Wait == 1);
endmodule
