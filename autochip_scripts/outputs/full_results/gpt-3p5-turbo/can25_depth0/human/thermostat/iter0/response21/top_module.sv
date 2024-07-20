module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

reg heater;
reg aircon;
reg fan;

always @(*) begin
	if (mode) begin      // heating mode
		if (too_cold || fan_on) begin
			heater = 1;
			aircon = 0;
			fan = 1;
		end
		else begin
			heater = 0;
			aircon = 0;
			fan = 0;
		end
	end
	else begin          // cooling mode
		if (too_hot || fan_on) begin
			heater = 0;
			aircon = 1;
			fan = 1;
		end
		else begin
			heater = 0;
			aircon = 0;
			fan = 0;
		end
	end
end

endmodule
