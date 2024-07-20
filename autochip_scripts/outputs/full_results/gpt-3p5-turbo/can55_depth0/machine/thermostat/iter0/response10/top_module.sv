module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

reg fan;
reg heater;
reg aircon;

always @* begin
	if (fan_on || too_cold || too_hot)
		fan = 1;
	else
		fan = 0;
	
	if (mode && too_cold)
		heater = 1;
	else
		heater = 0;
	
	if (!mode && too_hot)
		aircon = 1;
	else
		aircon = 0;
end

assign fan = fan;
assign heater = heater;
assign aircon = aircon;

endmodule
