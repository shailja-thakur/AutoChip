module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Code for controlling the temperature of a room
	
	// Turn on fan if it is too cold, too hot, or fan_on is high
	assign fan = (too_cold || too_hot || fan_on);
	
	// Turn on heater if mode is high and it is too cold
	assign heater = (mode && too_cold);
	
	// Turn on aircon if mode is low and it is too hot
	assign aircon = (!mode && too_hot);

endmodule
