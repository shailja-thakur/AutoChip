module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Use built-in OR gate to perform logical OR operation between inputs b and c
	assign q = b | c;

endmodule
