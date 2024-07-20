module top_module(
	input ring,
	input vibrate_mode,
	output ringer,
	output motor
);

reg ringer;
reg motor;

// Logic for controlling ringer and motor
always @ (ring or vibrate_mode)
begin
	if (vibrate_mode == 1)	// If phone is in vibrate mode
	begin
		ringer = 0;		// Turn off ringer
		motor = 1;		// Turn on motor
	end
	else	// If phone is not in vibrate mode
	begin
		ringer = 1;		// Turn on ringer
		motor = 0;		// Turn off motor
	end
end

endmodule
