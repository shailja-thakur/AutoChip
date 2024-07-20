module top_module (
	input [7:0] in,
	output parity
);

	// Internal signals
	wire [7:0] xor_result;
	
	// Calculate the parity bit
	assign xor_result = ^in;
	assign parity = xor_result;

endmodule
