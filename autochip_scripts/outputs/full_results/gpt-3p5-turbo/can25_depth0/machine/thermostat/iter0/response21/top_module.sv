module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

assign fan = (fan_on || too_cold || too_hot) ? 1'b1 : 1'b0; // Control fan based on inputs
assign heater = (mode && too_cold) ? 1'b1 : 1'b0; // Turn on heater if mode is high and too_cold is high
assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0; // Turn on aircon if mode is low and too_hot is high

endmodule
