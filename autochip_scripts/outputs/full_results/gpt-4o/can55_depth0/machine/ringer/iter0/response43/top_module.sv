module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

	// Assign statements to control ringer and motor outputs
	assign ringer = ring & ~vibrate_mode; // Ringer on when ring is 1 and vibrate_mode is 0
	assign motor = ring & vibrate_mode;   // Motor on when both ring and vibrate_mode are 1

endmodule
