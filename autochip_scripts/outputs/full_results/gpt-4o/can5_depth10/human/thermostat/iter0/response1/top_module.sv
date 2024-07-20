module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Heater control
	assign heater = (mode == 1 && too_cold == 1) ? 1 : 0;
	
	// Air conditioner control
	assign aircon = (mode == 0 && too_hot == 1) ? 1 : 0;
	
	// Fan control - fan should be on if the heater or air conditioner is on, or if fan_on is requested
	assign fan = (heater == 1 || aircon == 1 || fan_on == 1) ? 1 : 0;

endmodule
