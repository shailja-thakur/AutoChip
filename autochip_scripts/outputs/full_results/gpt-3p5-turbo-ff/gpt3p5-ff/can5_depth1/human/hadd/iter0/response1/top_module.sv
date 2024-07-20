module top_module (
	input a,
	input b,
	output sum,
	output cout
);
	// logic for the half adder
	assign sum = a ^ b;
	assign cout = a & b;
endmodule
