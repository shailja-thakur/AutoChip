module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Internal signal to determine if fan should be on
wire fan_control;

// Determine if fan should be on based on fan_on input or if heater or aircon are on
assign fan_control = fan_on | (mode & too_cold) | (~mode & too_hot);

// Determine if heater should be on based on mode and too_cold input
assign heater = mode & too_cold;

// Determine if aircon should be on based on mode and too_hot input
assign aircon = ~mode & too_hot;

// Assign fan output based on fan_control signal
assign fan = fan_control;

endmodule
