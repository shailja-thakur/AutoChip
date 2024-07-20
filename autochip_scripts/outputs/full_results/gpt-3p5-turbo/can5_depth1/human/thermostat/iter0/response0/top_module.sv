module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Enable heater when it is too cold and in heating mode
	assign heater = (mode == 1) & too_cold;

	// Enable air conditioner when it is too hot and in cooling mode
	assign aircon = (mode == 0) & too_hot;

	// Enable fan when heater, air conditioner, or fan request is active
	assign fan = heater | aircon | fan_on;

endmodule
