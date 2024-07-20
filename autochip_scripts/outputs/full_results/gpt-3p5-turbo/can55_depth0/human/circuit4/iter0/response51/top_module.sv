module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// assign value to output q based on the input waveforms
	
	assign q = (~a & ~b & ~c & d) | (~a & ~b & c) | (~a & b & ~c) | (b & ~c & d) | (b & c & d);
	
endmodule
