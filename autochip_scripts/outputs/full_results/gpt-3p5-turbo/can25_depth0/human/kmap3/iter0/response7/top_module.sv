module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
	assign out = (~a & ~b & ~c & d) | (~a & ~b & c & d) | (~c & ~d & b) | (~c & d & b);
endmodule
