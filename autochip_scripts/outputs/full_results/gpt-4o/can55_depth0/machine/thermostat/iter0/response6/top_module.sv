module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Fan control
	assign fan = too_cold || too_hot || fan_on;

	// Heater control
	assign heater = mode && too_cold;

	// Air conditioner control
	assign aircon = !mode && too_hot;

endmodule
