module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Internal signals
wire fan_control;
wire heater_control;
wire aircon_control;

// Fan control logic
assign fan_control = (fan_on || too_cold || too_hot);

// Heater control logic
assign heater_control = (mode && too_cold);

// Aircon control logic
assign aircon_control = (!mode && too_hot);

// Output signals
assign fan = fan_control;
assign heater = heater_control;
assign aircon = aircon_control;

endmodule
