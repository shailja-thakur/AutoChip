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
	reg fan_ctrl;

	// Control the heater/aircon/fan based on conditions
	always @(*) begin
		if (mode == 1) begin
			heater = too_cold;
			aircon = 0;
			fan_ctrl = fan_on || (heater || aircon);
		end else begin
			heater = 0;
			aircon = too_hot;
			fan_ctrl = fan_on || (heater || aircon);
		end
	end

	// Assign fan based on control signal
	assign fan = fan_ctrl;

endmodule
