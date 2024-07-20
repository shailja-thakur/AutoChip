module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

// Implement the XNOR gate
assign in1_xnor_in2 = !(in1 ^ in2);

// Implement the XOR gate
assign out = in1_xnor_in2 ^ in3;

endmodule
