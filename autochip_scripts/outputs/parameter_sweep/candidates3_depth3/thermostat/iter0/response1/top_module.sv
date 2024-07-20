module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Fan control
	assign fan = (fan_on) ? 1 : ((mode && too_cold) || (!mode && too_hot)) ? 1 : 0;

	// Heater control
	assign heater = (!mode && too_cold && !fan_on) ? 1 : 0;

	// Air conditioner control
	assign aircon = (mode && too_hot && !fan_on) ? 1 : 0;

endmodule
