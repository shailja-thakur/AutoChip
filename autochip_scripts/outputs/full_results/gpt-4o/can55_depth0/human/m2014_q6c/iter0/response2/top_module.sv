module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

    // Derive logic equations for Y2 and Y4 based on the state diagram.
    // States encoding:
    // A - 000001
    // B - 000010
    // C - 000100
    // D - 001000
    // E - 010000
    // F - 100000

    // Next state transitions:
    // Y2 represents state B (Y2 = 1 when next state is B)
    // Y4 represents state D (Y4 = 1 when next state is D)

    // From the state diagram, transitions:
    // A (0) --0--> B -> Y2 = y[1] & ~w
    // C (0) --0--> E -> Y4 = y[3] & ~w
    // D (0) --0--> F -> Y4 = y[4] & w
    // E (1) --1--> D -> Y4 = y[5] & ~w
    // F (1) --0--> C -> Y4 = y[6] & w
    
    assign Y2 = y[1] & ~w;
    assign Y4 = (y[2] & w) | (y[3] & ~w) | (y[4] & w) | (y[6] & w);

endmodule
