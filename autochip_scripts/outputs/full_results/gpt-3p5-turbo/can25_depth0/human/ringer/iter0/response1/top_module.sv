module top_module(
	input ring,
	input vibrate_mode,
	output ringer,
	output motor
);

// Logic to determine whether to turn on the ringer or motor
assign ringer = (~vibrate_mode) & ring;
assign motor = vibrate_mode & (~ring);

endmodule
