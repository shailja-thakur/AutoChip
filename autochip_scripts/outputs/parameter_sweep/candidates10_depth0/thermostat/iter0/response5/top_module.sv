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
	wire fan_control;
	
	// Determine if the fan should be turned on
	assign fan = (fan_on || mode) ? 1'b1 : 1'b0;

	// Determine if the heater should be turned on
	assign heater = (mode && too_cold && !fan_on) ? 1'b1 : 1'b0;
	
	// Determine if the air conditioner should be turned on
	assign aircon = (!mode && too_hot && !fan_on) ? 1'b1 : 1'b0;

endmodule
