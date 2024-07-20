module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	//Performing the AND operation
	assign out_and = &in;
	
	//Performing the OR operation
	assign out_or = |in;
	
	//Performing the XOR operation
	assign out_xor = ^in;

endmodule
