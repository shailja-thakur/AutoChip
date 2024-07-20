module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
    // Assign statements for controlling ringer and motor outputs
    assign ringer = ring & ~vibrate_mode;
    assign motor = ring & vibrate_mode;
endmodule
