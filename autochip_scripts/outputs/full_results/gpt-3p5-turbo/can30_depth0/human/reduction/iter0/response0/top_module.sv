module top_module (
	input [7:0] in,
	output parity
);
	// Define internal signals
	wire [7:0] xor_out;
	wire parity_bit;
	
	// Generate the XOR of all input bits
	assign xor_out = ^in;
	
	// Compute the parity bit as the XOR of all input bits
	assign parity_bit = ^xor_out;
	
	// Output the result
	assign parity = parity_bit;
endmodule
