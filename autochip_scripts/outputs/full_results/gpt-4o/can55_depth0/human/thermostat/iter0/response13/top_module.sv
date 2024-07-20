module top_module(
	input mode,       // Mode: 1 for heating, 0 for cooling
	input too_cold,   // Signal indicating it is too cold
	input too_hot,    // Signal indicating it is too hot
	input fan_on,     // Signal to manually turn on the fan
	output heater,    // Output to control the heater
	output aircon,    // Output to control the air conditioner
	output fan        // Output to control the fan
);

	// Internal signals
	wire heater_on, aircon_on;

	// Heater is on if mode is heating and it is too cold
	assign heater_on = mode && too_cold;

	// Air conditioner is on if mode is cooling and it is too hot
	assign aircon_on = ~mode && too_hot;

	// Heater or air conditioner control the fan
	assign heater = heater_on;
	assign aircon = aircon_on;
	assign fan = heater_on || aircon_on || fan_on;

endmodule
