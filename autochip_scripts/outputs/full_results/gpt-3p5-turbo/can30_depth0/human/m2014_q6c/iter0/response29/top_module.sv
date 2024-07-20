module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

wire A, B, C, D, E, F;

assign A = y[6];
assign B = y[5];
assign C = y[4];
assign D = y[3];
assign E = y[2];
assign F = y[1];

assign Y2 = (B & ~w) | (E & w);
assign Y4 = (D & ~w) | (C & w);

endmodule
