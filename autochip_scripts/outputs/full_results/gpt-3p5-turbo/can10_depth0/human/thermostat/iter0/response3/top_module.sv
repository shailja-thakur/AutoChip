module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

reg heater;
reg aircon;
reg fan;

always @(mode or too_cold or too_hot or fan_on)
begin
	if (mode == 1) // heating mode
	begin
		if (too_cold == 1) // turn on the heater if it is too cold
			heater = 1;
		else // turn off the heater if it is not too cold
			heater = 0;
			
		// always turn on the fan
		fan = 1;
		
		// turn off the air conditioner
		aircon = 0;
	end
	else // cooling mode
	begin
		// turn off the heater
		heater = 0;
		
		if (too_hot == 1) // turn on the air conditioner if it is too hot
			aircon = 1;
		else // turn off the air conditioner if it is not too hot
			aircon = 0;
			
		// always turn on the fan
		fan = 1;
	end
	
	// explicitly turn on the fan if fan_on is 1
	if (fan_on == 1)
		fan = 1;
end

endmodule
