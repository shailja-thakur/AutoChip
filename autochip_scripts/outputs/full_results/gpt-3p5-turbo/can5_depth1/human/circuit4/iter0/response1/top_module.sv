module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Create your logic here
assign q = (~a & b & ~c & ~d) | (a & ~b & ~c & d) | (a & b & c & d);

endmodule
