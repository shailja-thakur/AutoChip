module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Declare internal signals for fan and temperature control
	wire fan_control;
	wire temperature_control;

	// Assign fan control signal
	assign fan = fan_on || too_cold || too_hot;

	// Assign temperature control signals
	assign heater = (mode == 1) && too_cold;
	assign aircon = (mode == 0) && too_hot;

endmodule
