module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Implementation of the cellphone's ringer and vibration motor control circuit
// The ringer and motor are mutually exclusive, based on the vibrate mode input

// Assign ringer and motor outputs based on input conditions
assign ringer = (vibrate_mode == 1'b1) ? 1'b0 : 1'b1;
assign motor = (vibrate_mode == 1'b1) ? 1'b1 : 1'b0;

endmodule
