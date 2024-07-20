module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output reg heater,
	output reg aircon,
	output reg fan
);

	// Control the fan
	always @ (mode or too_cold or too_hot or fan_on)
	begin
		if (fan_on || too_cold || too_hot)
			fan = 1;
		else
			fan = 0;
	end

	// Control the heater
	always @ (mode or too_cold)
	begin
		if (mode && too_cold)
			heater = 1;
		else
			heater = 0;
	end

	// Control the air conditioner
	always @ (mode or too_hot)
	begin
		if (!mode && too_hot)
			aircon = 1;
		else
			aircon = 0;
	end
endmodule
