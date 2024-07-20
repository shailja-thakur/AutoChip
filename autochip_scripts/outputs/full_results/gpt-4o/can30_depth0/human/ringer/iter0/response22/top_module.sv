module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	// Set outputs based on vibrate_mode
	assign ringer = ring & ~vibrate_mode; // Turn on the ringer if ring is high and vibrate_mode is low
	assign motor = ring & vibrate_mode;   // Turn on the motor if ring is high and vibrate_mode is high
endmodule
