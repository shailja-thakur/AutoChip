module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Internal wire declarations
	wire fan;
	wire heater;
	wire aircon;

	// Fan control
	assign fan = (too_cold || too_hot || fan_on) ? 1'b1 : 1'b0;

	// Heater control
	assign heater = (mode && too_cold) ? 1'b1 : 1'b0;

	// Air conditioner control
	assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0;
endmodule
