module top_module (
	input [7:0] in,
	output parity
);

	// Declare internal wire to hold the intermediate calculation
	wire parity_wire;

	// Perform the bitwise XOR operation on the input bits
	xor8 parity_checker (
		.in(in),
		.out(parity_wire)
	);

	// Assign the final result to the output port
	assign parity = parity_wire;
endmodule
module xor8 (
	input [7:0] in,
	output out
);
	
	assign out = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

endmodule
