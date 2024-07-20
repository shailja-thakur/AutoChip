module top_module (
	input [7:0] in,
	output parity
);

	// Declare internal wires or regs
	wire [7:0] data;
	wire temp_parity;

	// Assign input to internal wires
	assign data = in;

	// Compute even parity
	xor8 xor_inst (
		.in(data),
		.out(temp_parity)
	);

	// Assign parity bit
	assign parity = temp_parity;

endmodule
module xor8 (
	input [7:0] in,
	output out
);

	// Declare internal wires or regs
	wire [3:0] xor_out;

	// Compute XOR for each pair of bits
	xor2 xor2_inst1 (
		.in1(in[0], in[1]),
		.out(xor_out[0])
	);
	xor2 xor2_inst2 (
		.in1(in[2], in[3]),
		.out(xor_out[1])
	);
	xor2 xor2_inst3 (
		.in1(in[4], in[5]),
		.out(xor_out[2])
	);
	xor2 xor2_inst4 (
		.in1(in[6], in[7]),
		.out(xor_out[3])
	);

	// Compute XOR for pairs of XOR results
	xor2 xor2_inst5 (
		.in1(xor_out[0], xor_out[1]),
		.out(xor_out[4])
	);
	xor2 xor2_inst6 (
		.in1(xor_out[2], xor_out[3]),
		.out(xor_out[5])
	);

	// Compute final XOR for the 6 XOR results
	xor2 xor2_inst7 (
		.in1(xor_out[4], xor_out[5]),
		.out(out)
	);

endmodule
module xor2 (
	input in1,
	input in2,
	output out
);

	assign out = in1 ^ in2;

endmodule
