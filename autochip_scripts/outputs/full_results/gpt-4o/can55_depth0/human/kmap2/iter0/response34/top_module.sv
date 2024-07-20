module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

    assign out = (~c & ~d) | (~a & ~b) | (~a & d) | (b & ~c & d) | (a & c & d) | (a & b & ~d) | (a & ~b & c);

endmodule
