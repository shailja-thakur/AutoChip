module top_module(
	input mode,
	input too_cold,
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Declare internal signal to control the fan
wire fan_ctrl;

// Logic to control the heater
assign heater = (mode == 1 && too_cold) || fan_on;

// Logic to control the air conditioner
assign aircon = (mode == 0 && too_hot) || fan_on;

// Logic to control the fan
assign fan = heater || aircon || fan_on;

endmodule
