module top_module (
	input [7:0] in,
	output parity
);

	// Internal wires
	wire [7:0] in_xor;
	wire parity_bit;

	// Compute XOR of input bits
	xor_gate_8_bit xor_gate_1 (
		.in(in),
		.out(in_xor)
	);

	// Compute parity bit
	xor_gate_9_bit xor_gate_2 (
		.in({in_xor, 1'b0}),
		.out(parity_bit)
	);

	// Output parity bit
	assign parity = parity_bit;

endmodule
module xor_gate_8_bit (
	input [7:0] in,
	output [7:0] out
);
	genvar i;
	wire [7:0] xor_wires;

	// Compute XOR of input bits
	generate
		for (i = 0; i < 8; i = i + 1) begin : xor_block
			assign xor_wires[i] = in[i] ^ in[i+1];
		end
	endgenerate

	// Output XOR result
	assign out = xor_wires;

endmodule
module xor_gate_9_bit (
	input [8:0] in,
	output out
);
	wire [7:0] xor_wires;

	// Compute XOR of input bits
	assign xor_wires = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7] ^ in[8];

	// Output XOR result
	assign out = xor_wires;

endmodule
