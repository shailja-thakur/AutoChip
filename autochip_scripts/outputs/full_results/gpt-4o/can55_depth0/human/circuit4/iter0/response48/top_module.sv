module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	assign q = (q == 0 || a == 0) ? b | c : d;

endmodule
