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
	wire fan_ctrl;
	wire heater_ctrl;
	wire aircon_ctrl;

	// Fan control logic
	assign fan_ctrl = (fan_on || too_cold || too_hot) ? 1'b1 : 1'b0;
	assign fan = fan_ctrl;

	// Heater control logic
	assign heater_ctrl = (mode && too_cold) ? 1'b1 : 1'b0;
	assign heater = heater_ctrl;

	// Aircon control logic
	assign aircon_ctrl = (!mode && too_hot) ? 1'b1 : 1'b0;
	assign aircon = aircon_ctrl;

endmodule
