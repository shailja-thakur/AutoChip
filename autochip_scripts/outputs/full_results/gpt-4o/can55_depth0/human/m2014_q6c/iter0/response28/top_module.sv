module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Next state logic for Y2
	// Y2 corresponds to state B (000010)
	// From state A (000001) to state B (000010) when w = 0
	// From state D (001000) to state B (000010) when w = 1
	assign Y2 = (~w & y[1]) | (w & y[4]);

	// Next state logic for Y4
	// Y4 corresponds to state D (001000)
	// From state B (000010) to state D (001000) when w = 1
	// From state C (000100) to state D (001000) when w = 1
	// From state E (010000) to state D (001000) when w = 1
	// From state F (100000) to state D (001000) when w = 1
	assign Y4 = (w & y[2]) | (w & y[3]) | (w & y[5]) | (w & y[6]);

endmodule
