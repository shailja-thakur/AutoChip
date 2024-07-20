module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
	// Behavior of the circuit based on the given simulation waveforms
	assign q = (~a & ~c & ~d) | (~b & ~c & ~d) | (~b & ~a & ~c) | (~b & ~a & ~d);

endmodule
