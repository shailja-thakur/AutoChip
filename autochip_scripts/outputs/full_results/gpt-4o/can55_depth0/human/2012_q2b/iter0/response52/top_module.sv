module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	wire state_A = y[0];
	wire state_B = y[1];
	wire state_C = y[2];
	wire state_D = y[3];
	wire state_E = y[4];
	wire state_F = y[5];

	// Define the outputs for Y1 and Y3
	assign Y1 = (state_A && w) || (state_B && ~w);
	assign Y3 = (state_B && ~w) || (state_C && ~w) || (state_D && ~w) || (state_E && ~w) || (state_F && ~w);

endmodule
