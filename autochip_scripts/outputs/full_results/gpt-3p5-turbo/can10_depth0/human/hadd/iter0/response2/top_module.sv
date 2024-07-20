module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	assign sum = a ^ b; // XOR gate
	assign cout = a & b; // AND gate

endmodule
