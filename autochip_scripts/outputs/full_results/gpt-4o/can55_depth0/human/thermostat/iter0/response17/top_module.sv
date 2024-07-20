module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    // Heater is active in heating mode and when too cold
    assign heater = mode && too_cold;

    // Air conditioner is active in cooling mode and when too hot
    assign aircon = ~mode && too_hot;

    // Fan is active when either the heater or air conditioner is on or the user requested it
    assign fan = heater || aircon || fan_on;

endmodule
