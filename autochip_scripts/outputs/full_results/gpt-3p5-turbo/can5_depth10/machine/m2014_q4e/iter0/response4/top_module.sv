module top_module (
	input in1,
	input in2,
	output logic out
);
	
	// Logical OR of in1 and in2
	logic or_output;
	assign or_output = in1 | in2;
	
	// Logical negation of or_output
	assign out = ~or_output;
	
endmodule
