module top_module (
	input clk,
	input in,
	output logic out
);

	// Declare flip-flop output
	logic xor_output;

	// Declare and instantiate D flip-flop
	d_ff dff (
		.clk(clk),
		.d(xor_output),
		.q(out)
	);

	// Declare and instantiate XOR gate
	xor2 xor_gate (
		.a(in),
		.b(out),
		.z(xor_output)
	);

endmodule
module d_ff (
	input clk,
	input d,
	output reg q
);
	always @(posedge clk)
		q <= d;

endmodule
module xor2 (
	input a,
	input b,
	output z
);
	assign z = a ^ b;

endmodule
