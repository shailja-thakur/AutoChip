module top_module (
	input [7:0] in,
	output parity
);
// Define internal wires
wire [7:0] xor_out;
wire parity_bit;

// Implement XOR gate for all input bits
assign xor_out = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

// Implement even parity bit calculation
assign parity_bit = ~xor_out;

// Assign output to the parity bit
assign parity = parity_bit;

endmodule
