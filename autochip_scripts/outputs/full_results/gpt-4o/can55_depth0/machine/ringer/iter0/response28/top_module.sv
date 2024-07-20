module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

    // Assign statement for ringer output
    assign ringer = ring & ~vibrate_mode;

    // Assign statement for motor output
    assign motor = ring & vibrate_mode;

endmodule
