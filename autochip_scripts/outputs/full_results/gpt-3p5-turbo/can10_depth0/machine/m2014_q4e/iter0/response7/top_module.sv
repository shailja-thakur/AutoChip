module top_module (
	input in1,
	input in2,
	output logic out
);

	// Implementing the logical OR of in1 and in2
	logic or_result;
	assign or_result = in1 | in2;
	
	// Implementing the logical negation of or_result
	assign out = ~or_result;
	
endmodule
