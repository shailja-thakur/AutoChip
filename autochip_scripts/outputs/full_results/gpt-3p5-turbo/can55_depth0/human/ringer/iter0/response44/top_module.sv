module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

	// Declare internal wire
	wire select;

	// Logic to determine select signal
	assign select = (vibrate_mode == 1) ? 1'b0 : 1'b1;

	// Logic to control ringer and motor
	assign ringer = (select == 1) ? ring : 1'b0;
	assign motor = (select == 0) ? ring : 1'b0;

endmodule
