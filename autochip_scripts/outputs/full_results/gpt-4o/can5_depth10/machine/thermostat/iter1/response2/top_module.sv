module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    // Heater control logic
    assign heater = mode & too_cold;
    
    // Air conditioner control logic
    assign aircon = ~mode & too_hot;
    
    // Fan control logic
    // Fan will be on if either too_cold or too_hot is high, or if fan_on is high.
    assign fan = (too_cold | too_hot | fan_on);
    
endmodule
