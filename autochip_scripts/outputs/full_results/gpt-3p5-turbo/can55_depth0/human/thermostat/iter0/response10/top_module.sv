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
	if (mode == 1) // heating mode
	begin
		heater = (too_cold || fan_on) ? 1 : 0;
		aircon = 0;
		fan = (heater || aircon || fan_on) ? 1 : 0;
	end
	else // cooling mode
	begin
		heater = 0;
		aircon = (too_hot || fan_on) ? 1 : 0;
		fan = (heater || aircon || fan_on) ? 1 : 0;
	end
end

endmodule
