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
	if (mode == 1) begin // heating mode
		heater = (too_cold || fan_on) ? 1 : 0;
		aircon = 0;
		fan = (heater || fan_on) ? 1 : 0;
	end else begin // cooling mode
		heater = 0;
		aircon = (too_hot || fan_on) ? 1 : 0;
		fan = (aircon || fan_on) ? 1 : 0;
	end
end

endmodule
