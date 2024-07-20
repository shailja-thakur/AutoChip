module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
    assign out = (~c & ~d & a & ~b) | (~c & d & a) | (~c & ~d & ~a) | (~c & d & ~b) |
                 (c & d & a & b) | (c & ~d & b) | (c & d & b) | (c & b & ~a);
endmodule
