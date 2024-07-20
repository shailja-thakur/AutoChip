module top_module (
	input [7:0] in,
	output parity
);

// Define an internal wire for intermediate calculations
wire [7:0] xor_result;

// Compute the XOR of all input bits
assign xor_result = ^in;

// Compute the parity bit
assign parity = xor_result;

endmodule
