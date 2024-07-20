module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	assign q = (~a & c & ~d) | (b & c) | (a & ~b & c) | (a & ~c & d) | (a & ~b & ~c);
	
endmodule
