module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	// Assigning the ringer and motor outputs based on the ring and vibrate_mode inputs
	assign ringer = (vibrate_mode == 1'b1) ? 1'b0 : ring;
	assign motor = (vibrate_mode == 1'b1) ? 1'b1 : 1'b0;
endmodule
