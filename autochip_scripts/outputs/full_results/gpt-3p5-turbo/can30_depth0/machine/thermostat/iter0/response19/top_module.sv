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
	wire heater_control;
	wire aircon_control;

	// Assign fan_control signal
	assign fan_control = fan_on || too_cold || too_hot;

	// Assign heater_control signal
	assign heater_control = (mode == 1'b1) && too_cold;

	// Assign aircon_control signal
	assign aircon_control = (mode == 1'b0) && too_hot;

	// Assign outputs
	assign heater = heater_control;
	assign aircon = aircon_control;
	assign fan = fan_control;

endmodule
