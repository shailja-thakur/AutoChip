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
	
	always @(*) begin
		if (mode == 1) begin
			if (too_cold == 1 || fan_on == 1)
				heater = 1;
			else
				heater = 0;
			aircon = 0;
			fan = heater | fan_on;
		end else begin
			if (too_hot == 1 || fan_on == 1)
				aircon = 1;
			else
				aircon = 0;
			heater = 0;
			fan = aircon | fan_on;
		end
	end
endmodule
