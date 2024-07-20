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
reg fan_state;

// Heater and Air conditioner control logic
always @ (mode, too_cold, too_hot) begin
	if (mode == 1 && too_cold) begin
		heater = 1;
		aircon = 0;
	end else if (mode == 0 && too_hot) begin
		heater = 0;
		aircon = 1;
	end else begin
		heater = 0;
		aircon = 0;
	end
end

// Fan control logic
always @ (heater, aircon, fan_on) begin
	if (heater || aircon || fan_on) begin
		fan = 1;
		fan_state = 1;
	end else if (!fan_state) begin
		fan = 0;
	end
end

endmodule
