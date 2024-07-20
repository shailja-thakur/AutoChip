module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
    
    // Assign the ringer output based on the input signals
    assign ringer = (vibrate_mode == 1) ? 0 : ring;
    
    // Assign the motor output based on the vibrate mode input signal
    assign motor = (vibrate_mode == 1) ? 1 : 0;
    
endmodule
