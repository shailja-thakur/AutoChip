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
		// Determine fan state
		if (too_cold || too_hot || fan_on) 
			fan = 1'b1;
		else 
			fan = 1'b0;

		// Determine heater state
		if (mode && too_cold) 
			heater = 1'b1;
		else 
			heater = 1'b0;
		
		// Determine aircon state
		if (!mode && too_hot) 
			aircon = 1'b1;
		else 
			aircon = 1'b0;
	end

endmodule
