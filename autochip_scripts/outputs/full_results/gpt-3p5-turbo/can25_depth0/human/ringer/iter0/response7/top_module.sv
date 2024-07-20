module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Instantiate the circuit
ring_vibrate_control ring_controller(
	.ring(ring),
	.vibrate_mode(vibrate_mode),
	.ringer(ringer),
	.motor(motor)
);

endmodule
module ring_vibrate_control(
	input ring,
	input vibrate_mode,
	output ringer,
	output motor
);

// Turn on the motor if vibrate mode is enabled
assign motor = vibrate_mode;

// Turn on the ringer if vibrate mode is not enabled
assign ringer = ~vibrate_mode;

endmodule
