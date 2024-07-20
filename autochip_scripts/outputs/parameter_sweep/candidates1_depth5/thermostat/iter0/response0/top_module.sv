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

always @(*)
begin
	heater = 0; // initialize heater to 0
	aircon = 0; // initialize air conditioner to 0
	fan = fan_on; // set fan output to fan_on input value

	if(mode == 1) // heating mode
	begin
		if(too_cold == 1) // turn on heater when it is too cold
		begin
			heater = 1;
			aircon = 0;
		end
	end
	else // cooling mode
	begin
		if(too_hot == 1) // turn on air conditioner when it is too hot
		begin
			heater = 0;
			aircon = 1;
		end
	end
	
	// Turn on fan if heater or air conditioner are on, or if fan_on is requested
	if(heater == 1 || aircon == 1 || fan_on == 1)
		fan = 1;
	else
		fan = 0;
	
end

endmodule
