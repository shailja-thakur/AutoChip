module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

    // State encoding: Use one-hot encoding for states
    // 000001: A
    // 000010: B
    // 000100: C
    // 001000: D
    // 010000: E
    // 100000: F

    assign Y1 = (y[0] & w);  // State B is 'Y1' and is reached from state A if w = 1

    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[5] & ~w);  // State D is 'Y3' and is reached from state B or state C or state F if w = 0

endmodule
