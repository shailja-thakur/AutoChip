module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

	// Ringer is on if ring is active and not in vibrate mode
	assign ringer = ring & ~vibrate_mode;
	
	// Motor is on if ring is active and in vibrate mode
	assign motor = ring & vibrate_mode;

endmodule
