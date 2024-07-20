module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    // Heating mode: mode is high
	assign heater = mode & too_cold;
	
    // Cooling mode: mode is low
	assign aircon = ~mode & too_hot;
	
    // Fan control: fan will be turned on if too_cold or too_hot is high, or fan_on is high
	assign fan = too_cold | too_hot | fan_on;

endmodule
