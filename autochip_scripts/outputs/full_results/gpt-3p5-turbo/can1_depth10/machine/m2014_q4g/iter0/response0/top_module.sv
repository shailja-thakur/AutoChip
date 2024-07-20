module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// wire for intermediate output
	logic intermediate;

	// XOR operation between in1 and in2
	assign intermediate = in1 ^ in2;

	// NOT operation on intermediate
	assign intermediate = ~intermediate;

	// XOR operation between intermediate and in3
	assign out = intermediate ^ in3;

endmodule
