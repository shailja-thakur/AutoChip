module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Internal signals
wire ringer_on;
wire motor_on;

// Ringer control logic
assign ringer_on = (~vibrate_mode) & ring;
assign ringer = ringer_on;

// Motor control logic
assign motor_on = vibrate_mode & ring;
assign motor = motor_on;

endmodule
