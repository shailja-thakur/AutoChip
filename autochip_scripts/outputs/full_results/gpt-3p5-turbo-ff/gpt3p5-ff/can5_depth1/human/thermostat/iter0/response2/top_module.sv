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
reg fan_on_internal;

// Assign fan_on_internal signal based on fan_on input and mode
always @ (fan_on or mode)
begin
	if (fan_on || mode)
		fan_on_internal = 1;
	else
		fan_on_internal = 0;
end

// Assign heater output based on mode and temperature conditions
assign heater = (mode && too_cold && !too_hot) ? 1 : 0;

// Assign aircon output based on mode and temperature conditions
assign aircon = (!mode && !too_cold && too_hot) ? 1 : 0;

// Assign fan output as OR of fan_on_internal, heater and aircon outputs
assign fan = fan_on_internal || heater || aircon;

endmodule
