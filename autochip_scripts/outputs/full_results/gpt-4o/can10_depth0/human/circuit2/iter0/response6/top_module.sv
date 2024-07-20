module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

assign q = (a & b & c & d) | (~a & ~d) | (a & d & ~b & ~c) | (b & c & ~a & ~d);

endmodule
