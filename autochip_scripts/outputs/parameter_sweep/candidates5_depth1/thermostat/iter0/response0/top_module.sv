module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// assign the heater output based on the mode and temperature conditions
	assign heater = (mode && too_cold && !fan_on) ? 1'b1 : 1'b0;

	// assign the air conditioner output based on the mode and temperature conditions
	assign aircon = (!mode && too_hot && !fan_on) ? 1'b1 : 1'b0;

	// assign the fan output based on the fan_on input and either the heater or aircon being on
	assign fan = (fan_on || heater || aircon) ? 1'b1 : 1'b0;

endmodule
