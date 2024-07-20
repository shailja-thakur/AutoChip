module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
    
    // Implement the logic for controlling the ringer and motor
    // Turn on the motor if the phone is in vibrate mode
    assign motor = vibrate_mode;
    
    // Otherwise, turn on the ringer
    assign ringer = ~vibrate_mode;
    
endmodule
