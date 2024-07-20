module top_module (
	input a,
	input b,
	output sum,
	output cout
);
    assign sum = a ^ b;  // sum = a XOR b
    assign cout = a & b;  // cout = a AND b
endmodule
