module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define intermediate wire signals
	wire w1, w2, w3, w4;

	// Assign intermediate wire signals
	assign w1 = a & b;
	assign w2 = c & d;
	assign w3 = w1 | w2;
	assign w4 = ~w3;

	// Assign q output
	assign q = w4;

endmodule
