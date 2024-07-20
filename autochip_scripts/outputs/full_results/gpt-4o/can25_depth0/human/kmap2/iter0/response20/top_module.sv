module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

    assign out = (~c & ~d & ~b) | (~c & ~d & a) | (~c & b & ~a) | (~c & a & b) |
                 (c & ~d & ~a) | (c & ~d & b) | (c & a & b) | (~d & ~a & ~b);

endmodule
