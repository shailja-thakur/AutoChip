module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    assign heater = mode & too_cold; // Heater is turned on if mode is high (heating mode) and too_cold is high
    assign aircon = ~mode & too_hot; // Air conditioner is turned on if mode is low (cooling mode) and too_hot is high
    assign fan = too_cold | too_hot | fan_on; // Fan is turned on if either too_cold, too_hot, or fan_on is high

endmodule
