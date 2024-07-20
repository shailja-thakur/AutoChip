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
	wire heater_on;
	wire aircon_on;
	wire fan_on_internal;

	// Logic for heater
	assign heater_on = (mode == 1) && (too_cold == 1);
	assign heater = heater_on;

	// Logic for air conditioner
	assign aircon_on = (mode == 0) && (too_hot == 1);
	assign aircon = aircon_on;

	// Logic for fan
	assign fan_on_internal = fan_on || heater_on || aircon_on;
	assign fan = fan_on_internal;
endmodule
