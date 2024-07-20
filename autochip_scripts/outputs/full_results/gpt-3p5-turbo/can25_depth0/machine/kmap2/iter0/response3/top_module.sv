module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	assign out = (c & b) ? 0 :
				(d & a) ? 0 :
				(a & c & d) ? 1 :
				(b & c & d) ? 1 :
				0;

endmodule
