module top_module (
	input [3:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Declare wire variables for intermediate results
	wire out_and_temp, out_or_temp, out_xor_temp;

	// Implement AND gate
	assign out_and_temp = in[0] & in[1] & in[2] & in[3];

	// Implement OR gate
	assign out_or_temp = in[0] | in[1] | in[2] | in[3];

	// Implement XOR gate
	assign out_xor_temp = in[0] ^ in[1] ^ in[2] ^ in[3];

	// Assign intermediate results to output ports
	assign out_and = out_and_temp;
	assign out_or = out_or_temp;
	assign out_xor = out_xor_temp;

endmodule
