module top_module(
	input a, 
	input b,
	output out
);

	xor #(2) x1 (.a(a), .b(b), .z(out));

endmodule
