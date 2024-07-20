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
wire fan;

assign fan = (fan_on == 1) | (heater == 1) | (aircon == 1);

always @(*)
begin
	if (mode == 1 && too_cold == 1) begin
		heater = 1;
		aircon = 0;
	end
	else if (mode == 0 && too_hot == 1) begin
		heater = 0;
		aircon = 1;
	end
	else begin
		heater = 0;
		aircon = 0;
	end
end

endmodule
