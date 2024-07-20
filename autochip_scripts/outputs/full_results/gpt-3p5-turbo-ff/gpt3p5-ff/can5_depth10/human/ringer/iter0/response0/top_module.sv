module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	// Assign signals to control ringer and motor based on input conditions
	assign ringer = vibrate_mode ? 0 : ring;
	assign motor = vibrate_mode ? ring : 0;
endmodule
