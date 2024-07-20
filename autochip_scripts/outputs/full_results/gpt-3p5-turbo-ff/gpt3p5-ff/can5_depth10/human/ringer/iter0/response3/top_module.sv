module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Implementation of the circuit logic
// If the phone is in vibrate mode, turn on the motor. Otherwise, turn on the ringer.

assign motor = vibrate_mode;
assign ringer = ~vibrate_mode;

endmodule
