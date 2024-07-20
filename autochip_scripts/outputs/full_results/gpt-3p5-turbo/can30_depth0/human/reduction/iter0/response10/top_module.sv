module top_module (
	input [7:0] in,
	output parity
);

// Internal wire to hold the computed parity bit
wire parity_bit;

// XOR gate to compute the parity bit
assign parity_bit = ^in;

// Output the parity bit
assign parity = parity_bit;

endmodule
