module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	// Control logic for ringer and motor
	assign ringer = vibrate_mode ? 0 : ring;
	assign motor = vibrate_mode ? ring : 0;
endmodule
