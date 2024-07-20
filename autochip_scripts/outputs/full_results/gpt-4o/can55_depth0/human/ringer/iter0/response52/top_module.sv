module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

    assign motor = ring & vibrate_mode;
    assign ringer = ring & ~vibrate_mode;

endmodule
