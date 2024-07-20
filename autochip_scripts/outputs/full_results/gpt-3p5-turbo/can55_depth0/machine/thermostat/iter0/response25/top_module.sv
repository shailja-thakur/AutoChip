module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Declare internal signals
reg fan;
reg heater;
reg aircon;

always @(too_cold or too_hot or mode or fan_on) begin
	// Fan logic
	if (fan_on || too_cold || too_hot) begin
		fan = 1;
	else
		fan = 0;
		
	// Heater logic
	if (mode && too_cold) begin
		heater = 1;
	else
		heater = 0;
		
	// Air conditioner logic
	if (!mode && too_hot) begin
		aircon = 1;
	else
		aircon = 0;
end

assign fan = fan;
assign heater = heater;
assign aircon = aircon;

endmodule
