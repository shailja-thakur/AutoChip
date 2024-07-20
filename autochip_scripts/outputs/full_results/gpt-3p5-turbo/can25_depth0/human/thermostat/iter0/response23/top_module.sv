module top_module(
	input mode,
	input too_cold,
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// logic to control heater
assign heater = (mode == 1 && too_cold) || fan_on;

// logic to control air conditioner
assign aircon = (mode == 0 && too_hot) || fan_on;

// logic to control fan
assign fan = heater || aircon || fan_on;

endmodule
