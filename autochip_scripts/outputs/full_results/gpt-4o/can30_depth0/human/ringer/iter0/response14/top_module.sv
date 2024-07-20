module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

    // Assign the ringer and motor based on the ring and vibrate_mode inputs
    assign ringer = ring & ~vibrate_mode;
    assign motor = ring & vibrate_mode;

endmodule
