module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Internal signals
	reg heater_internal;
	reg aircon_internal;
	reg fan_internal;

	always @(*) begin
		// Logic for heater
		if (mode && too_cold)
			heater_internal = 1;
		else
			heater_internal = 0;

		// Logic for air conditioner
		if (!mode && too_hot)
			aircon_internal = 1;
		else
			aircon_internal = 0;

		// Logic for fan
		if (heater_internal || aircon_internal || fan_on)
			fan_internal = 1;
		else
			fan_internal = 0;
	end

	// Assign outputs
	assign heater = heater_internal;
	assign aircon = aircon_internal;
	assign fan = fan_internal;

endmodule
