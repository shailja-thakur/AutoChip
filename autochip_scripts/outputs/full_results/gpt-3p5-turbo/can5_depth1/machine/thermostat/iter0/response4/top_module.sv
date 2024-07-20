module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Declare internal signals
	wire fan_control;

	// Assign fan output
	assign fan = (fan_on || too_cold || too_hot);

	// Assign heater output
	assign heater = (mode && too_cold);

	// Assign aircon output
	assign aircon = (!mode && too_hot);

endmodule
