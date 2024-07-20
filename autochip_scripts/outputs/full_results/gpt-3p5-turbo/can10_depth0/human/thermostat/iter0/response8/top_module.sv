module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Initialize heater, aircon and fan outputs to 0
reg heater = 0;
reg aircon = 0;
reg fan = 0;

// Logic for turning on and off the heater, aircon and fan
always @(*)
begin
	if (fan_on == 1) // If fan_on signal is high, turn on the fan
		fan = 1;
	else if (mode == 1 && too_cold == 1) // If mode is heating and it is too cold, turn on the heater and fan
	begin
		heater = 1;
		fan = 1;
	end
	else if (mode == 0 && too_hot == 1) // If mode is cooling and it is too hot, turn on the aircon and fan
	begin
		aircon = 1;
		fan = 1;
	end
	else // In all other cases, turn off the heater, aircon and fan
	begin
		heater = 0;
		aircon = 0;
		fan = 0;
	end
end

endmodule
