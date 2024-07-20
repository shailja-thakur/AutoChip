module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
	
	// instantiate heater, aircon and fan modules
	heater_module heater_inst(
		.mode(mode),
		.too_cold(too_cold),
		.fan_on(fan_on),
		.heater(heater),
		.fan(fan)
	);
	
	aircon_module aircon_inst(
		.mode(mode),
		.too_hot(too_hot),
		.fan_on(fan_on),
		.aircon(aircon),
		.fan(fan)
	);
	
	// heater module definition
	module heater_module(
		input mode,
		input too_cold,
		input fan_on,
		output heater,
		output fan
	);
	
		assign heater = (mode == 1) && too_cold;
		assign fan = (heater || fan_on) ? 1 : 0;
	
	endmodule
module aircon_module(
		input mode,
		input too_hot,
		input fan_on,
		output aircon,
		output fan
	);
	
		assign aircon = (mode == 0) && too_hot;
		assign fan = (aircon || fan_on) ? 1 : 0;
	
	endmodule
