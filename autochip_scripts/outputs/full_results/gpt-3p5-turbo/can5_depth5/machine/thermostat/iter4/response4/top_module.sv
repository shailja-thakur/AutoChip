module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Control the fan
	assign fan = fan_on || too_cold || too_hot;

	// Control the heater
	assign heater = (mode && too_cold) || fan_on; // Turn on heater if mode is high and too_cold is high, or if fan_on is high

	// Control the air conditioner
	assign aircon = (!mode && too_hot) || fan_on; // Turn on aircon if mode is low and too_hot is high, or if fan_on is high
endmodule
