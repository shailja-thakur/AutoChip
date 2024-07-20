module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	assign ringer = ring & ~vibrate_mode; // set ringer to 1 when ring is 1 and vibrate_mode is 0, otherwise 0
	assign motor = ring & vibrate_mode; // set motor to 1 when both ring and vibrate_mode are 1, otherwise 0
endmodule
