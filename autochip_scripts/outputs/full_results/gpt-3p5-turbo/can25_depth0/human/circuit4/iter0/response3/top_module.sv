module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// This is a combinational circuit that implements a logic function.
// The output 'q' is a result of the logic function based on the inputs 'a', 'b', 'c', and 'd'.
// Read the simulation waveforms to determine the logic function.

assign q = (a & !b & !c & d) | (!a & b & !c & d) | (!a & !b & c & !d) | (!a & !b & c & d) | (!a & b & c & !d) | (!a & b & c & d);

endmodule
