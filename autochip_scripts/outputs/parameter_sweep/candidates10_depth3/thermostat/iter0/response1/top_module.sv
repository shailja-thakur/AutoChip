module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

// Internal signal to check if heater should be turned on
wire heater_on;

// Internal signal to check if air conditioner should be turned on
wire aircon_on;

// Logic to control heater
assign heater = (mode && too_cold) ? 1'b1 : 1'b0; // Turn on heater when in heating mode and too cold

// Logic to control air conditioner
assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0; // Turn on air conditioner when in cooling mode and too hot

// Logic to control fan
assign fan = (fan_on || heater || aircon) ? 1'b1 : 1'b0; // Turn on fan if fan is requested or heater or air conditioner is turned on

endmodule
