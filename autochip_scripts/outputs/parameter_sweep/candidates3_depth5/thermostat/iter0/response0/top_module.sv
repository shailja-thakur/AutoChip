module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// heater control
	assign heater = (mode && too_cold) ? 1'b1 : 1'b0;

	// air conditioner control
	assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0;

	// fan control
	assign fan = (heater || aircon || fan_on) ? 1'b1 : 1'b0;

endmodule
