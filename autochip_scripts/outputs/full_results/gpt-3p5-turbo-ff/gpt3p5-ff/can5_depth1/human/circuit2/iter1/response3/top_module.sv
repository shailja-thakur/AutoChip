module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Implement the circuit based on the given simulation waveforms
	// Use blocking assignment to ensure correct waveform propagation
	
	assign q = (!a & !b & !c & !d) | (a & !b & c) | (!a & b & !c & !d) | (a & b & c);
	
endmodule
