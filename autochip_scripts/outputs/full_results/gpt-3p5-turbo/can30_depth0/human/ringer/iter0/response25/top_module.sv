module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

	// Assign the ringer and motor outputs based on the input signals
	assign ringer = vibrate_mode ? 0 : ring;
	assign motor = vibrate_mode ? 1 : ring;
    
endmodule
