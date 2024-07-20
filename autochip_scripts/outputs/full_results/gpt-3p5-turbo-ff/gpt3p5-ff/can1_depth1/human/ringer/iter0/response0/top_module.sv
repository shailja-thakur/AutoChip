module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Turn on the ringer if not in vibrate mode
assign ringer = ~vibrate_mode;

// Turn on the motor if in vibrate mode
assign motor = vibrate_mode;

endmodule
