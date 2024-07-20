module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

	// Check if the phone is in vibrate mode
	assign motor = vibrate_mode ? 1 : 0;
	
	// Check if the phone needs to ring or not
	assign ringer = vibrate_mode ? 0 : ring;
	
endmodule
