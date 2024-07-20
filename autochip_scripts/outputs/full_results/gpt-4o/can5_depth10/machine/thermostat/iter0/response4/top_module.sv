module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    // Control the fan output
    assign fan = fan_on || too_cold || too_hot;

    // Control the heater output
    assign heater = mode && too_cold;

    // Control the air conditioner output
    assign aircon = ~mode && too_hot;

endmodule
