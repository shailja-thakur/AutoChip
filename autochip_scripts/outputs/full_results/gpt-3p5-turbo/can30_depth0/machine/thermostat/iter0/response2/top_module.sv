module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Internal signal to control the fan
	wire fan_ctrl;
	// Internal signal to control the heater
	wire heater_ctrl;
	// Internal signal to control the air conditioner
	wire aircon_ctrl;

	// Logic to determine the fan control
	assign fan_ctrl = fan_on || too_cold || too_hot;

	// Logic to determine the heater control
	assign heater_ctrl = mode && too_cold;

	// Logic to determine the air conditioner control
	assign aircon_ctrl = !mode && too_hot;

	// Assign outputs
	assign fan = fan_ctrl;
	assign heater = heater_ctrl;
	assign aircon = aircon_ctrl;

endmodule
