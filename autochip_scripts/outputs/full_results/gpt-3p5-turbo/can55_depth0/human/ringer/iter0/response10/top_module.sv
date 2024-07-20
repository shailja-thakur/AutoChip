module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	// Control logic for the ringer and motor
	// If the phone is in vibrate mode, turn on the motor. Otherwise, turn on the ringer.
	assign motor = vibrate_mode ? 1'b1 : 1'b0;
	assign ringer = vibrate_mode ? 1'b0 : 1'b1;
endmodule
