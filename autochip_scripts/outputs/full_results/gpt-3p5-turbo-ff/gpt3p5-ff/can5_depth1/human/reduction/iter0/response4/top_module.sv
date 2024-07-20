module top_module (
	input [7:0] in,
	output parity
);

	// Wire declaration for XOR gate
	wire [7:0] xor_out;
	
	// XOR gate implementation for computing parity bit
	assign xor_out = ^in;
	assign parity = xor_out;
	
endmodule
