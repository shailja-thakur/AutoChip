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

always @ (mode or too_cold or too_hot or fan_on) begin
	if (mode && too_cold)
		heater = 1;
	else
		heater = 0;

	if (!mode && too_hot)
		aircon = 1;
	else
		aircon = 0;

	if (heater || aircon || fan_on)
		fan = 1;
	else
		fan = 0;
end

endmodule
