module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define intermediate signals
	wire w;

	// Assign intermediate signals
	assign w = ~(a|b) & c & d;

	// Assign output
	assign q = (w & ~(a|b)) | (~w & ~(a|b|c));

endmodule
