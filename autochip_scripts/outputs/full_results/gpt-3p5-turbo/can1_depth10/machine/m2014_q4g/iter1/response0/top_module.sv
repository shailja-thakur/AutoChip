module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);

	// wire for intermediate output
	logic intermediate_xor;
	logic intermediate_not;

	// XOR operation between in1 and in2
	assign intermediate_xor = in1 ^ in2;

	// NOT operation on intermediate
	assign intermediate_not = ~intermediate_xor;

	// XOR operation between intermediate and in3
	assign out = intermediate_not ^ in3;

endmodule
