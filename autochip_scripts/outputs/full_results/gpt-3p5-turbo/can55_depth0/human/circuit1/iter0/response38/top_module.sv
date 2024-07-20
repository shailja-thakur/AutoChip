module top_module (
	input a, 
	input b, 
	output q
);
	
	assign q = a & ~b; // Implementing the logic based on the simulation waveforms

endmodule
