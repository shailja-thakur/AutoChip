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

always @(*)
begin
	if (mode == 1) // Heating mode
	begin
		if (too_cold == 1)
		begin
			heater = 1;
			aircon = 0;
		end
		else
		begin
			heater = 0;
			aircon = 0;
		end
	end
	else // Cooling mode
	begin
		if (too_hot == 1)
		begin
			heater = 0;
			aircon = 1;
		end
		else
		begin
			heater = 0;
			aircon = 0;
		end
	end

	if (heater == 1 || aircon == 1 || fan_on == 1)
		fan = 1;
	else
		fan = 0;
end

endmodule
