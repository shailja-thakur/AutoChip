module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

// Y1 is the input to the state flip-flop y[1]
// From the state diagram, the transitions for y[1] are:
// A (0) --1--> B
// B (0) --0--> D
// C (0) --0--> D
// D (0) --1--> F
// E (1) --0--> D
// F (1) --0--> D
assign Y1 = (y[0] & w) | (y[1] & ~w) | (y[3] & ~w) | (y[5] & ~w);

// Y3 is the input to the state flip-flop y[3]
// From the state diagram, the transitions for y[3] are:
// A (0) --0--> A
// B (0) --1--> C
// C (0) --0--> D
// D (0) --0--> A
// E (1) --1--> E
// F (1) --1--> C
assign Y3 = (y[0] & ~w) | (y[1] & w) | (y[2] & ~w) | (y[4] & w);

endmodule
