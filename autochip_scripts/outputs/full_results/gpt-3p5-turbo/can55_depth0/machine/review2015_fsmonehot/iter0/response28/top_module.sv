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

	parameter S = 10'b0000000001;   // state S
	parameter S1 = 10'b0000000010;  // state S1
	parameter S11 = 10'b0000000100; // state S11
	parameter S110 = 10'b0000001000;  // state S110
	parameter B0 = 10'b0000010000;  // state B0
	parameter B1 = 10'b0000100000;  // state B1
	parameter B2 = 10'b0001000000;  // state B2
	parameter B3 = 10'b0010000000;  // state B3
	parameter Count = 10'b0100000000;  // state Count
	parameter Wait = 10'b1000000000;  // state Wait

	// Done signal is 1 in the Wait state
	assign done = (state & Wait) ? 1 : 0;

	// Counting signal is 1 in the Count state
	assign counting = (state & Count) ? 1 : 0;

	// Shift enable signal is 1 if any of the states B3, B2, B1 and B0 is active
	assign shift_ena = (state & (B3 | B2 | B1 | B0)) ? 1 : 0;

	// Output B3_next is 1 when the state B2 is active
	assign B3_next = (state & B2) ? 1 : 0;

	// Output S_next is 1 when the state S and d is 0, or the state S1 and d is 0,
  // or the state S110 and d is 0, or the state Wait and ack is 1
	assign S_next = ((state & S & ~d) | (state & S1 & ~d) | (state & S110 & ~d) | (state & Wait & ack)) ? 1 : 0;

	// Output S1_next is 1 when the state S and d is 1
	assign S1_next = (state & S & d) ? 1 : 0;

	// Output Count_next is 1 when the state B3 is active, or the state Count 
  //and done_counting is 0
	assign Count_next = ((state & B3) | (state & Count & ~done_counting)) ? 1 : 0;

	// Output Wait_next is 1 when the state Count and done_counting is 1,
  // or the state Wait and ack is 0
	assign Wait_next = ((state & Count & done_counting) | (state & Wait & ~ack)) ? 1 : 0;

endmodule
