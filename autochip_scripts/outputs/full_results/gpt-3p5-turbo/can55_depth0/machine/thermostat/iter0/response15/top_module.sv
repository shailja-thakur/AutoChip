module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

    reg fan;

    assign fan = (fan_on || too_cold || too_hot);

    assign fan = (too_cold || too_hot || fan_on);

    assign heater = (mode && too_cold);
    assign aircon = (!mode && too_hot);

endmodule
