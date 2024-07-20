module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
	// Output signals for heater, aircon, and fan
	reg heater, aircon, fan;
	
	always @(*) begin
		if (mode == 1) begin // Heating mode
			heater = too_cold;
			aircon = 0;
			fan = fan_on || heater; // Fan is on if heater is on or fan is requested
		end else begin // Cooling mode
			heater = 0;
			aircon = too_hot;
			fan = fan_on || aircon; // Fan is on if aircon is on or fan is requested
		end
	end
endmodule
