module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    // Turn on the heater in heating mode if it's too cold
    assign heater = mode & too_cold;

    // Turn on the air conditioner in cooling mode if it's too hot
    assign aircon = ~mode & too_hot;

    // Turn on the fan if either the heater, air conditioner, or fan_on is active
    assign fan = heater | aircon | fan_on;

endmodule
