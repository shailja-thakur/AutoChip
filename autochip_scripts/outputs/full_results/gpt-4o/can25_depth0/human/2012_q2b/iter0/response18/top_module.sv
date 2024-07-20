module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
    // y[5:0] = 000001(A), 000010(B), 000100(C), 001000(D), 010000(E), 100000(F)
    // Y1 is the input for state B (y[1])
    // Y3 is the input for state D (y[3])

    // For state B:
    // A (0) --1--> B
    assign Y1 = y[0] & w;

    // For state D:
    // B (0) --0--> D
    // C (0) --0--> D
    // D (0) --0--> A
    // F (1) --0--> D
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[5] & ~w);

endmodule
