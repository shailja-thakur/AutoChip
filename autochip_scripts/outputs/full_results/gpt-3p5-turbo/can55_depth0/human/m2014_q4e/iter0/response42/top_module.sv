module top_module (
	input in1,
	input in2,
	output logic out
);
	nor_gate ng1 (in1, in2, out);

endmodule
module nor_gate (
	input in1,
	input in2,
	output logic out
);
	assign out = ~(in1 | in2);

endmodule
