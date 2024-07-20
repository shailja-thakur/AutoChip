module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Fan control logic
	assign fan = too_cold || too_hot || fan_on;
	
	// Heater control logic
	assign heater = mode && too_cold;
	
	// Air conditioner control logic
	assign aircon = ~mode && too_hot;

endmodule
