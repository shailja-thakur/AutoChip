module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Declare the OR gate output
	wire q;

	// Perform the OR operation on inputs b and c
	assign q = b | c;

endmodule
