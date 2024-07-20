module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// wire for output control signals
wire fan_control;

// assign fan control based on fan_on input and mode
assign fan_control = (fan_on || (mode && too_cold) || (!mode && too_hot));

// assign heater, aircon, and fan outputs based on mode and temperature inputs
assign heater = (mode && too_cold) ? 1'b1 : 1'b0;
assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0;
assign fan = fan_control;

endmodule
