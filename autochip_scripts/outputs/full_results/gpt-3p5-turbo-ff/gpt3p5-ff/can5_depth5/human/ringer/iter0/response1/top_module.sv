module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	// Use a ternary operator to decide whether to turn on the ringer or the motor
	assign ringer = (vibrate_mode) ? 0 : ring;
	assign motor = (vibrate_mode) ? ring : 0;
endmodule
