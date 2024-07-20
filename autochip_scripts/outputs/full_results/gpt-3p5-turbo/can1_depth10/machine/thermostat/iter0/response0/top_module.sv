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
	assign fan = (fan_on || too_cold || too_hot) ? 1'b1 : 1'b0;

	// Heater control
	assign heater = (mode && too_cold) ? 1'b1 : 1'b0;

	// Aircon control
	assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0;

endmodule
