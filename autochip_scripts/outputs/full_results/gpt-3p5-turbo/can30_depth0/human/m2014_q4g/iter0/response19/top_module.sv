module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// Instantiate the XNOR gate
	xnor_gate xnor_inst (
		.in1(in1),
		.in2(in2),
		.xnor_out(xnor_out)
	);

	// Instantiate the XOR gate
	xor_gate xor_inst (
		.in1(xnor_out),
		.in2(in3),
		.xor_out(out)
	);

	// Internal wire for the output of the XNOR gate
	wire xnor_out;

endmodule
module xnor_gate (
	input in1,
	input in2,
	output xnor_out
);
	assign xnor_out = ~(in1 ^ in2);
endmodule
module xor_gate (
	input in1,
	input in2,
	output xor_out
);
	assign xor_out = in1 ^ in2;
endmodule
