module top_module(
	input ring, 
	input vibrate_mode,
	output ringer,
	output motor
);
	
	// Wire for controlling the ringer and motor
	wire ringer_control, motor_control;
	
	// Assign output ringer and motor based on vibrate_mode and ring inputs
	assign ringer = vibrate_mode ? 0 : ringer_control;
	assign motor = vibrate_mode ? motor_control : 0;
	
	// Logic for controlling the ringer and motor based on ring and vibrate_mode inputs
	always @(ring, vibrate_mode) begin
		if (vibrate_mode)
			motor_control <= 1;
		else if (ring)
			ringer_control <= 1;
		else
			begin
			motor_control <= 0;
			ringer_control <= 0;	
			end
	end
	
endmodule
