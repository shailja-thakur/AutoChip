module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// Declare internal signal for fan control
	reg fan_ctrl;

	// Declare internal signal for heater control
	reg heater_ctrl;

	// Declare internal signal for aircon control
	reg aircon_ctrl;

	// Logic for controlling fan
	always @*
	begin
		if (fan_on || heater_ctrl || aircon_ctrl)
			fan_ctrl = 1;
		else
			fan_ctrl = 0;
	end

	// Logic for controlling heater and aircon based on mode
	always @*
	begin
		if (mode)
		begin
			heater_ctrl = too_cold;
			aircon_ctrl = 0;
		end
		else
		begin
			heater_ctrl = 0;
			aircon_ctrl = too_hot;
		end
	end

	// Assign internal signals to outputs
	assign heater = heater_ctrl;
	assign aircon = aircon_ctrl;
	assign fan = fan_ctrl;

endmodule
