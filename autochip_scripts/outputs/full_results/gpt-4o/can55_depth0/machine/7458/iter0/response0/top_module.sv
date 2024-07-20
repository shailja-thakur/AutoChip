module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

	// Calculate p1y
	wire p1_and_result, p1_or_result;
	assign p1_and_result = p1a & p1b & p1c;
	assign p1_or_result = p1d | p1e | p1f;
	assign p1y = p1_and_result | p1_or_result;

	// Calculate p2y
	wire p2_and_result, p2_or_result;
	assign p2_and_result = p2a & p2b;
	assign p2_or_result = p2c | p2d;
	assign p2y = p2_and_result & p2_or_result;

endmodule
