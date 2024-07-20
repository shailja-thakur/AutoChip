module top_module (
	input [7:0] in,
	output parity
);

	// Define internal signals
	wire [7:0] xor_result;
	wire even_parity;

	// Compute the XOR of all 8 data bits
	assign xor_result = ^in;

	// Compute the even parity bit
	assign even_parity = ~xor_result;

	// Assign the output
	assign parity = even_parity;

endmodule
