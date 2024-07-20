module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Implement the circuit based on the given simulation waveforms
assign q = (b & ~c & ~d) | (~b & c & ~d) | (a & b & c & d) | (a & ~b & c & d) | (a & b & ~c & d) | (a & b & c & ~d);

endmodule
