module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

	// Instantiate an OR gate to determine if either ring or vibrate_mode is high
	assign motor = (ring || vibrate_mode) ? 1'b1 : 1'b0;
	
	// Assign ringer as the inverse of motor
	assign ringer = ~motor;
	
endmodule
