module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Declare internal wire
wire ringer_signal;
wire motor_signal;

// Control logic
assign ringer_signal = ~vibrate_mode & ring;
assign motor_signal = vibrate_mode & ring;

// Output assignment
assign ringer = ringer_signal;
assign motor = motor_signal;

endmodule
