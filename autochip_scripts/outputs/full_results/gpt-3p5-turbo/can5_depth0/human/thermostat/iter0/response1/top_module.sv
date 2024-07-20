module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Signal to control the heater
	reg heater;
	
	// Signal to control the air conditioner
	reg aircon;
	
	// Signal to control the fan
	reg fan;
	
	// Control logic
	always @(mode, too_cold, too_hot, fan_on)
	begin
		if (mode == 1 && too_cold)
		begin
			heater = 1;
			aircon = 0;
			fan = 1;
		end
		else if (mode == 0 && too_hot)
		begin
			heater = 0;
			aircon = 1;
			fan = 1;
		end
		else if (mode == 1 && fan_on)
		begin
			heater = 0;
			aircon = 0;
			fan = 1;
		end
		else if (mode == 0 && fan_on)
		begin
			heater = 0;
			aircon = 0;
			fan = 1;
		end
		else
		begin
			heater = 0;
			aircon = 0;
			fan = 0;
		end
	end
endmodule
