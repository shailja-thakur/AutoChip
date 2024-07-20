module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

assign out = (~a & ~c & d) | (a & ~b & d) | (a & ~b & ~c) | (b & ~c & d);
endmodule
