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
	if (mode == 1 && too_cold)
		heater = 1;
	else if (mode == 0 && too_hot)
		aircon = 1;
	else
		heater = 0;
		aircon = 0;
	
	if (fan_on || heater || aircon)
		fan = 1;
	else
		fan = 0;
end

endmodule
