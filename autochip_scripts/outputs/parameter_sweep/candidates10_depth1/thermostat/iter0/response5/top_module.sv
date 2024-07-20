module top_module(
	input mode,
	input too_cold,
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Declare internal signal for fan control
wire fan_control;

// Fan control logic
assign fan_control = fan_on | (too_cold & mode) | (too_hot & ~mode);

// Assign outputs
assign heater = too_cold & mode;
assign aircon = too_hot & ~mode;
assign fan = fan_control;

endmodule
