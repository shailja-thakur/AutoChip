module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
	// Declare intermediate signals
	wire y1_bit, y3_bit;
	
	// Assign intermediate signals
	assign y1_bit = y[0] & w;
	assign y3_bit = (y[1] | y[2] | y[4] | y[5]) & ~w;

	// Assign output signals
	assign Y1 = y1_bit;
	assign Y3 = y3_bit;
endmodule
