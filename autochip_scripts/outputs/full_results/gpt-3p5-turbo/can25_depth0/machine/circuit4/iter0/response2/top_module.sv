module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Declare internal wires
	wire b_or_c;
	
	// Logic gates
	assign b_or_c = b | c;
	assign q = b_or_c;

endmodule
