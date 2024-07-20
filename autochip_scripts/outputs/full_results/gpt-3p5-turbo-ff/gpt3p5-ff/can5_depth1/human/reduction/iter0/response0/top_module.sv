module top_module (
	input [7:0] in,
	output parity
);

	// wire to hold the result of the XOR operation
	wire xor_result;

	// assign the XOR result to the parity output
	assign parity = xor_result;

	// XOR all the input bits using an XOR reduction operator
	assign xor_result = ^in;

endmodule
