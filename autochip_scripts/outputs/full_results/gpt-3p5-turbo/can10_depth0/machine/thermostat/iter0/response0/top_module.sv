module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Assigning the fan output based on the conditions
	assign fan = (fan_on || too_cold || too_hot) ? 1'b1 : 1'b0;
	
	// Assigning the heater output based on the conditions
	assign heater = (mode && too_cold) ? 1'b1 : 1'b0;
	
	// Assigning the aircon output based on the conditions
	assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0;

endmodule
