module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output reg heater,
	output reg aircon,
	output reg fan
);

	always @(*) begin
		// Determine the state of the fan
		if(too_cold || too_hot || fan_on)
			fan = 1;
		else
			fan = 0;
		
		// Determine the state of the heater and air conditioner based on mode
		if(mode) begin
			// Heating mode
			if(too_cold)
				heater = 1;
			else
				heater = 0;
			
			aircon = 0; // Ensure air conditioner is off in heating mode
		end else begin
			// Cooling mode
			if(too_hot)
				aircon = 1;
			else
				aircon = 0;
			
			heater = 0; // Ensure heater is off in cooling mode
		end
	end

endmodule
