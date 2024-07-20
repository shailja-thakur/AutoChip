module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
	
	// Heater Control
	assign heater = (mode && too_cold) || fan_on;
	
	// Air Conditioner Control
	assign aircon = (!mode && too_hot) || fan_on;
	
	// Fan Control
	assign fan = heater || aircon || fan_on;
	
endmodule
