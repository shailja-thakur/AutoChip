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
	wire fan_control;
	wire fan_on_output;

	// Fan control logic
	assign fan_control = (fan_on == 1) || (heater == 1) || (aircon == 1);

	// Fan control output
	assign fan_on_output = (fan_on == 1) || (fan_control == 1);

	// Heater control logic
	assign heater = (mode == 1) && (too_cold == 1);

	// Air conditioner control logic
	assign aircon = (mode == 0) && (too_hot == 1);

	// Final fan output
	assign fan = fan_on_output;

endmodule
