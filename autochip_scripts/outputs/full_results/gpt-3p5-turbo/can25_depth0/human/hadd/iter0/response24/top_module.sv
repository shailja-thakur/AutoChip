module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	
	assign sum = a ^ b; // XOR operation
	assign cout = a & b; // AND operation
	
endmodule
