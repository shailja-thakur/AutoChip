module top_module(
	input ring, 
	input vibrate_mode,
	output wire ringer,
	output wire motor
);

	assign ringer = ring && !vibrate_mode;
	assign motor = ring && vibrate_mode;

endmodule
