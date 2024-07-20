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
	wire fan_on_auto;

	// Fan control logic
	assign fan = (fan_on || (heater || aircon)) ? 1'b1 : 1'b0;
	
	// Mode control logic
	assign heater = (mode && too_cold && !too_hot) ? 1'b1 : 1'b0;
	assign aircon = (!mode && too_hot && !too_cold) ? 1'b1 : 1'b0;
	
endmodule
