module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Turn on either the ringer or the motor based on the inputs
assign ringer = (vibrate_mode) ? 0 : ring;
assign motor = (vibrate_mode) ? ring : 0;

endmodule
