module top_module (
	input in1,
	input in2,
	output logic out
);

	// Combinational logic implementation
	assign out = ~(in1 | in2);

endmodule
