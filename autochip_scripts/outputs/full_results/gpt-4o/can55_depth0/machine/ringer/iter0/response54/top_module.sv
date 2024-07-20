module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

	assign ringer = ring & ~vibrate_mode; // Ringer is active when ring is 1 and vibrate_mode is 0
	assign motor = ring & vibrate_mode;   // Motor is active when both ring and vibrate_mode are 1

endmodule
