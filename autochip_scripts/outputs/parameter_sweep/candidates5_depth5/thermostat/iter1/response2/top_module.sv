module top_module(
	input mode,
	input too_cold,
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	assign heater = (mode && too_cold) || fan_on;
	assign aircon = (!mode && too_hot) || fan_on;
	assign fan = heater || aircon || fan_on;

	always@(mode, too_cold, too_hot, fan_on)
	begin
		heater <= (mode && too_cold) || fan_on;
		aircon <= (!mode && too_hot) || fan_on;
		fan <= heater || aircon || fan_on;
	end

endmodule
