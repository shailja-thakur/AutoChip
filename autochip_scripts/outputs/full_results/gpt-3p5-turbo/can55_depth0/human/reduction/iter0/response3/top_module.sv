module top_module (
	input [7:0] in,
	output parity
);
	// Declaring a wire for the XOR operation
	wire [7:0] xor_output;
	
	// Generating the parity bit using XOR operation
	assign xor_output = ^in;
	
	// Assigning the result of the XOR operation to the parity output
	assign parity = xor_output[0];
	
endmodule
