module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);

// Logic to control the ringer and motor based on the input signals
always @ (ring or vibrate_mode)
begin
	if (vibrate_mode == 1)
	begin
		// If the phone is in vibrate mode, turn on the motor
		ringer = 0;
		motor = 1;
	end
	else
	begin
		// If the phone is not in vibrate mode, turn on the ringer
		ringer = 1;
		motor = 0;
	end
end

endmodule
