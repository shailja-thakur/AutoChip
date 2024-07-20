module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// For Y1, the input of state flip-flop y[1]:
// A (0) --1--> B
// B (0) --0--> D
// C (0) --0--> D
// D (0) --1--> F
// E (1) --0--> D
// F (1) --0--> D
assign Y1 = (y[0] & w) | (y[1] & ~w) | (y[3] & ~w) | (y[5] & ~w);

// For Y3, the input of state flip-flop y[3]:
// A (0) --0--> A
// B (0) --1--> C
// C (0) --0--> D
// D (0) --0--> A
// E (1) --1--> E
// F (1) --1--> C
assign Y3 = (y[1] & w) | (y[2] & ~w) | (y[5] & w);

endmodule
