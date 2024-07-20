module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	
	wire xor1;
	wire not1;

	assign xor1 = in1 ^ in2;
	assign not1 = ~xor1;
	assign out = not1 ^ in3;

endmodule
