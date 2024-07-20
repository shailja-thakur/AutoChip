module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Heater control: Only in heating mode and when too cold
	assign heater = mode & too_cold;
	
	// Air conditioner control: Only in cooling mode and when too hot
	assign aircon = ~mode & too_hot;
	
	// Fan control: Turn on if either the heater or the air conditioner is on, or if fan_on is requested
	assign fan = heater | aircon | fan_on;

endmodule
