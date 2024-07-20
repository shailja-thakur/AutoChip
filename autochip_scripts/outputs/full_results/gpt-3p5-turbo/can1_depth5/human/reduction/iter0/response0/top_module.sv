module top_module (
	input [7:0] in,
	output parity
);

// Declare internal wire for each bit of the input
wire [7:0] in_bits;
assign in_bits = in;

// Compute the parity bit using XOR gate
wire parity_bit;
assign parity_bit = ^in_bits;

// Output the parity bit
assign parity = parity_bit;

endmodule
