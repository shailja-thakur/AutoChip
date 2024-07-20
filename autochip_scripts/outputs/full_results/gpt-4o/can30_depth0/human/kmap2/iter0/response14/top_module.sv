module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	assign out = (~c & ~d) | (c & d) | (~a & ~b & d) | (a & b & ~d & ~c);

endmodule
