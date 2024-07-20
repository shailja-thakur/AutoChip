module top_module(
	input a, 
	input b,
	input c,
	output out
);
	assign out =  ((~a & c) | (b & c) | (a & b) | (~b & ~c));
endmodule
