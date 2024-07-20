module top_module (
	input [7:0] in,
	output parity
);
	// Declare internal signal for parity bit
	wire parity_bit;
	
	// Compute the parity bit using bitwise XOR
	assign parity_bit = ^in;

	// Assign the parity bit to the output port
	assign parity = parity_bit;
endmodule
