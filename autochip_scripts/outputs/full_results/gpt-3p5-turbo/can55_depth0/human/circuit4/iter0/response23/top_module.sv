module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Intermediate signals
	wire at_least_two_high;
	wire sum_is_even;
	
	// Implementing the intermediate signals
	assign at_least_two_high = (a & (b | c | d)) | (b & (c | d)) | (c & d);
	assign sum_is_even = (a + b + c + d) % 2 == 0;
	
	// Output
	assign q = at_least_two_high & sum_is_even;

endmodule
