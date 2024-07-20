module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Implement the circuit based on the given simulation waveforms

	assign q = (~a & ~b & d) | (c & ~d) | (a & ~c & ~d);

endmodule
