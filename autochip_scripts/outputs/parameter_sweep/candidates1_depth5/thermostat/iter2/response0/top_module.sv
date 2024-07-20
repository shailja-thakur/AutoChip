module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

reg heater_reg;
reg aircon_reg;
wire fan_out;

assign heater = heater_reg;
assign aircon = aircon_reg;
assign fan = fan_out;

always @(mode, too_cold, too_hot, fan_on)
begin
	heater_reg <= 0; // initialize heater to 0
	aircon_reg <= 0; // initialize air conditioner to 0

	if (mode == 1) // heating mode
	begin
		if (too_cold == 1) // turn on heater when it is too cold
		begin
			heater_reg <= 1;
			aircon_reg <= 0;
		end
	end
	else // cooling mode
	begin
		if (too_hot == 1) // turn on air conditioner when it is too hot
		begin
			heater_reg <= 0;
			aircon_reg <= 1;
		end
	end
	
	// Turn on fan if heater or air conditioner are on, or if fan_on is requested
	if (heater_reg == 1 || aircon_reg == 1 || fan_on == 1)
		fan_out = 1;
	else
		fan_out = 0;
	
end

endmodule
