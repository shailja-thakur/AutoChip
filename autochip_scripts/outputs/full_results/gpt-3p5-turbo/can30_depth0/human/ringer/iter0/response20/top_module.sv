module top_module(
	input ring,
	input vibrate_mode,
	output ringer,
	output motor
);

	// Instantiate the ringer and motor modules
	ringer_module ringer_inst(
		.ring(ring),
		.vibrate_mode(vibrate_mode),
		.ringer(ringer)
	);
	
	motor_module motor_inst(
		.ring(ring),
		.vibrate_mode(vibrate_mode),
		.motor(motor)
	);
	
endmodule
module ringer_module(
	input ring,
	input vibrate_mode,
	output ringer
);

	// Implement the logic for the ringer module
	always @(ring, vibrate_mode)
	begin
		if (vibrate_mode == 1)
			ringer <= 0;
		else
			ringer <= ring;
	end
	
endmodule
module motor_module(
	input ring,
	input vibrate_mode,
	output motor
);

	// Implement the logic for the motor module
	always @(ring, vibrate_mode)
	begin
		if (vibrate_mode == 1)
			motor <= 1;
		else
			motor <= 0;
	end
	
endmodule
