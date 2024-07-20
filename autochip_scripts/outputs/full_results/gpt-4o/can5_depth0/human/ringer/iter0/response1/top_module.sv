module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

    // When ring signal is high and vibrate_mode is high, motor is turned on
    // When ring signal is high and vibrate_mode is low, ringer is turned on
    // Default state is both ringer and motor are off
    assign ringer = ring & ~vibrate_mode;
    assign motor  = ring & vibrate_mode;

endmodule
