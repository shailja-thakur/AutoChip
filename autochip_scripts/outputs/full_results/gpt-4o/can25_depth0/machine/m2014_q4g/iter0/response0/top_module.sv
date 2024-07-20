module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	
	logic temp;

	assign temp = in1 ^ in2;  // Perform XOR operation on in1 and in2
	assign out = (~temp) ^ in3;  // Perform bitwise NOT on the result and XOR with in3

endmodule
