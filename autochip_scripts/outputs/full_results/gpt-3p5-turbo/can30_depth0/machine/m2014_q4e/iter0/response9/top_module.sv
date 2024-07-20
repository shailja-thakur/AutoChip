module top_module (
	input in1,
	input in2,
	output logic out
);
	// Logical OR gate
	assign out = ~(in1 | in2);
endmodule
