module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	assign out = (~c & ~d & (~a | b)) |
	             (d & (~b | (a & c))) |
	             (c & d & b) |
	             (c & ~d & ~a);
endmodule
