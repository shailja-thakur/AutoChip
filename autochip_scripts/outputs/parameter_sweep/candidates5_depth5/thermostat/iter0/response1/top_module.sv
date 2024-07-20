module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Declare internal signal
	reg fan_signal;
	
	// Heater control logic
	always @ (mode, too_cold)
	begin
		if (mode == 1 && too_cold == 1)
			heater = 1;
		else
			heater = 0;
	end
	
	// Air conditioner control logic
	always @ (mode, too_hot)
	begin
		if (mode == 0 && too_hot == 1)
			aircon = 1;
		else
			aircon = 0;
	end
	
	// Fan control logic
	always @ (fan_on, heater, aircon)
	begin
		if (fan_on == 1 || heater == 1 || aircon == 1)
			fan_signal = 1;
		else
			fan_signal = 0;
	end
	
	// Assign outputs
	assign fan = fan_signal;
	
endmodule
