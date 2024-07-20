module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

	// Internal signals
	wire ringer_signal;
	wire motor_signal;

	// Assign outputs based on the mode
	assign ringer_signal = ring & ~vibrate_mode;
	assign motor_signal = ring & vibrate_mode;
	
	assign ringer = ringer_signal;
	assign motor = motor_signal;

endmodule
