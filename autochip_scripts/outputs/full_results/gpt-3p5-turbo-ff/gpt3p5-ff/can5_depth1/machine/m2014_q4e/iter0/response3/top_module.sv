module top_module (
	input in1,
	input in2,
	output logic out
);

// Define a wire for the logical OR of the two input signals
wire or_result;

// Implement the logical OR
assign or_result = in1 | in2;

// Implement the logical negation
assign out = ~or_result;

endmodule
