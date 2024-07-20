module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	
	// Declare internal wire
	wire turn_on_ringer;
	
	// Declare internal wire
	wire turn_on_motor;
	
	// Combinational logic to control ringer and motor
	assign turn_on_ringer = ~vibrate_mode & ring;
	assign turn_on_motor = vibrate_mode & ~ring;
	
	// Assign outputs
	assign ringer = turn_on_ringer;
	assign motor = turn_on_motor;
	
endmodule
