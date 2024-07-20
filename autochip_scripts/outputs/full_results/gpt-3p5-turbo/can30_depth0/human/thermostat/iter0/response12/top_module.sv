module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
// Declare internal signal
wire turn_on;

// Logic for determining when to turn on the heater or air conditioner
assign turn_on = (mode && too_cold) || (!mode && too_hot) || fan_on;

// Assign outputs based on the turn_on signal
assign heater = turn_on && mode;
assign aircon = turn_on && !mode;
assign fan = (turn_on || fan_on) && (heater || aircon);

endmodule
