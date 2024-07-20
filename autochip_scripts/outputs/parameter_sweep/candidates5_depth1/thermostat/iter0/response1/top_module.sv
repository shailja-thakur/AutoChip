module top_module(
	input mode,
	input too_cold,
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	// instantiate the heater, air conditioner, and fan modules
	heater_module heater_inst(
		.mode(mode),
		.too_cold(too_cold),
		.heater(heater),
		.fan(fan)
	);

	aircon_module aircon_inst(
		.mode(mode),
		.too_hot(too_hot),
		.aircon(aircon),
		.fan(fan)
	);

	fan_module fan_inst(
		.fan_on(fan_on),
		.fan(fan)
	);
	
endmodule
module heater_module(
	input mode,
	input too_cold,
	output reg heater,
	output reg fan
);
	always @(mode or too_cold) begin
		if (mode && too_cold) begin
			heater = 1; // turn on the heater
			fan = 1; // turn on the fan
		end
		else begin
			heater = 0; // turn off the heater
			fan = 0; // turn off the fan
		end
	end
endmodule
module aircon_module(
	input mode,
	input too_hot,
	output reg aircon,
	output reg fan
);
	always @(mode or too_hot) begin
		if (!mode && too_hot) begin
			aircon = 1; // turn on the air conditioner
			fan = 1; // turn on the fan
		end
		else begin
			aircon = 0; // turn off the air conditioner
			fan = 0; // turn off the fan
		end
	end
endmodule
module fan_module(
	input fan_on,
	output reg fan
);
	always @(fan_on) begin
		if (fan_on) begin
			fan = 1; // turn on the fan
		end
		else begin
			fan = 0; // turn off the fan
		end
	end
endmodule
