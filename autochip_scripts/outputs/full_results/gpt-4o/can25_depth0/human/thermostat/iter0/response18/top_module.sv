module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
    // Internal signals
    wire heater_on, aircon_on;

    // Heater is on in heating mode and when it's too cold
    assign heater_on = mode & too_cold;
    
    // Air conditioner is on in cooling mode and when it's too hot
    assign aircon_on = ~mode & too_hot;
    
    // Turn on the fan if either the heater or air conditioner is on or if fan_on is requested
    assign fan = heater_on | aircon_on | fan_on;

    // Connect heater and aircon outputs
    assign heater = heater_on;
    assign aircon = aircon_on;
    
endmodule
