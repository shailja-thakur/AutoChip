module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	// XOR operation between `in1` and `in2`
	logic xor_result = in1 ^ in2;
	
	// NOT operation on `xor_result`
	logic not_result = ~xor_result;
	
	// XOR operation between `not_result` and `in3` to get the final output
	assign out = not_result ^ in3;
	
endmodule
