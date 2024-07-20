module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// assign the fan output
	assign fan = fan_on || too_cold || too_hot;

	// assign the heater output
	assign heater = mode && too_cold;

	// assign the aircon output
	assign aircon = ~mode && too_hot;

endmodule
