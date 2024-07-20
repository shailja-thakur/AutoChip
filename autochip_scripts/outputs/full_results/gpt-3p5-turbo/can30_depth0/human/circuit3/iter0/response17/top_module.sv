module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// The waveforms indicate that the output q is a result of the combination of the inputs a,b,c, and d
	// Looking at the waveforms, we can determine that the output q is equal to 1 if and only if the four input bits are not all zeros

	assign q = ~(a & b & c & d); // Use NAND gate to implement the logic

endmodule
