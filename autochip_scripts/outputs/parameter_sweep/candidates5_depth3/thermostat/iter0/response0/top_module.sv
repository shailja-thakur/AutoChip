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
	reg heater_on;
	reg aircon_on;
	reg fan_on_internal;

	// Assign internal signals
	always @(mode, too_cold, too_hot, fan_on) begin
		if (mode) begin
			heater_on = too_cold; // Turn on heater when it is too cold
			aircon_on = 0; // Do not use air conditioner in heating mode
		end else begin
			heater_on = 0; // Do not use heater in cooling mode
			aircon_on = too_hot; // Turn on air conditioner when it is too hot
		end
		fan_on_internal = (fan_on || heater_on || aircon_on); // Turn on fan if requested, or if heater or air conditioner are on
	end

	// Assign output signals
	assign heater = heater_on;
	assign aircon = aircon_on;
	assign fan = fan_on_internal;

endmodule
