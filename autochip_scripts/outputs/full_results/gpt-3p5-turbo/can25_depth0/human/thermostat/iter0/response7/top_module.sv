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

always @ (mode or too_cold or too_hot or fan_on) begin
	if (mode == 1) begin   // Heating Mode
		heater = too_cold;
		aircon = 0;
		fan = fan_on || heater;  // Fan turns on if heater is on or fan_on is 1

	end else begin   // Cooling Mode
		heater = 0;
		aircon = too_hot;
		fan = fan_on || aircon;   // Fan turns on if aircon is on or fan_on is 1
	end
end

endmodule
