module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

reg heater, aircon, fan;

always @ (*) begin
	// Heating Mode
	if(mode == 1) begin
		if(too_cold)
			heater = 1;
		else
			heater = 0;
			
		aircon = 0;
		
		if(heater || fan_on)
			fan = 1;
		else
			fan = 0;
	// Cooling Mode
	else begin
		if(too_hot)
			aircon = 1;
		else
			aircon = 0;
			
		heater = 0;
		
		if(aircon || fan_on)
			fan = 1;
		else
			fan = 0;
	end
end

endmodule
