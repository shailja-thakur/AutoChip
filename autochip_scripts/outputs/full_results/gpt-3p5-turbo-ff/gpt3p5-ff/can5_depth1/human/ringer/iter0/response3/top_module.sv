module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	// Creating signal to determine which component to turn on
	wire need_ringer;
	assign need_ringer = ~vibrate_mode;
	
	// Ringer and motor control
	assign ringer = need_ringer & ring;
	assign motor = ~need_ringer & ring;
endmodule
