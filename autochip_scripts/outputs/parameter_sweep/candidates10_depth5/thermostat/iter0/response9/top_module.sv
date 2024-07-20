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
	wire fan_on_heating;
	wire fan_on_cooling;

	// Logic for fan control
	assign fan_on_heating = (fan_on == 1) || ((mode == 1) && (too_cold == 1));
	assign fan_on_cooling = (fan_on == 1) || ((mode == 0) && (too_hot == 1));

	// Output assignments
	assign heater = (mode == 1) && (too_cold == 1);
	assign aircon = (mode == 0) && (too_hot == 1);
	assign fan = (fan_on == 1) || fan_on_heating || fan_on_cooling;

endmodule
