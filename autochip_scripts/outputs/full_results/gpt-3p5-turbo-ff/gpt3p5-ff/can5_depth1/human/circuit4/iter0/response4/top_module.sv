module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Implement the logic for q based on the given simulation waveforms
assign q = (~a & ~b & ~c) | (d & ~a) | (d & c);

endmodule
