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

always @(mode or too_cold or too_hot or fan_on) begin
	if(mode == 1) begin
		if(too_cold == 1) begin
			heater <= 1;
			aircon <= 0;
			fan <= 1;
		end else begin
			heater <= 0;
			fan <= fan_on;
		end
	end else begin
		if(too_hot == 1) begin
			heater <= 0;
			aircon <= 1;
			fan <= 1;
		end else begin
			aircon <= 0;
			fan <= fan_on;
		end
	end
end
endmodule
