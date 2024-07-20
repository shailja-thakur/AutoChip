module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Declare internal signal to control ringer and motor
reg control;

// Assign control signal based on vibrate_mode input
always @ (vibrate_mode) begin
	if (vibrate_mode == 1)
		control = 0; // Vibrate mode, motor on
	else
		control = 1; // Normal mode, ringer on
end

// Assign ringer and motor outputs based on control signal and ring input
always @ (control, ring) begin
	if (ring == 1)
		ringer = control;
	else
		ringer = 0;
	motor = control;
end

endmodule
