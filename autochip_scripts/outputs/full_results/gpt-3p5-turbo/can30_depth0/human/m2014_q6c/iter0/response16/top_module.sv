module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

// State signal declarations
reg A, B, C, D, E, F;

// Combinational logic for next state generation
assign A = ~y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1];
assign B = ~y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] & y[1];
assign C = ~y[6] & ~y[5] & ~y[4] & ~y[3] & y[2] & ~y[1];
assign D = ~y[6] & ~y[5] & ~y[4] & ~y[3] & y[2] & y[1];
assign E = ~y[6] & ~y[5] & ~y[4] & y[3] & ~y[2] & ~y[1];
assign F = ~y[6] & ~y[5] & ~y[4] & y[3] & ~y[2] & y[1];

// Output signals
assign Y2 = D | F;
assign Y4 = C | D;

endmodule
