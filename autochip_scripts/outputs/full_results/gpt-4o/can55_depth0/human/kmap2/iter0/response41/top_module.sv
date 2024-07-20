module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

    assign out = (~c & ~d) | (~b & ~c) | (a & b & ~d) | (a & b & c);

endmodule
