module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
	// wire to_cold
	wire to_cold;
	assign to_cold = (mode == 1'b1) && (too_cold == 1'b1);

	// wire to_hot
	wire to_hot;
	assign to_hot = (mode == 1'b0) && (too_hot == 1'b1);

	// wire control_fan
	wire control_fan;
	assign control_fan = (fan_on == 1'b1) || (to_cold == 1'b1) || (to_hot == 1'b1);

	// wire control_heater
	wire control_heater;
	assign control_heater = (mode == 1'b1) && (to_cold == 1'b1);

	// wire control_aircon
	wire control_aircon;
	assign control_aircon = (mode == 1'b0) && (to_hot == 1'b1);

	// assign outputs
	assign heater = control_heater ? 1'b1 : 1'b0;
	assign aircon = control_aircon ? 1'b1 : 1'b0;
	assign fan = control_fan ? 1'b1 : 1'b0;
endmodule
