module top_module(
	input a, 
	input b,
	input c,
	output out
);

	assign out = (b & c) ? 1'b1 : (a & (b | c));
	
endmodule
