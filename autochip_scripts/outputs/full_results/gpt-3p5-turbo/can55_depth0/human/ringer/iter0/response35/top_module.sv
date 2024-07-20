module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	always @ (ring, vibrate_mode)
	begin
		if (vibrate_mode)
		begin
			// Phone is in vibrate mode, turn on the motor
			ringer = 0;
			motor = 1;
		end
		else
		begin
			// Phone is not in vibrate mode, turn on the ringer
			ringer = 1;
			motor = 0;
		end
	end
endmodule
