module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

reg fan;
reg heater;
reg aircon;

always @(*) begin
    fan = (too_cold || too_hot || fan_on);
    heater = (mode && too_cold);
    aircon = (!mode && too_hot);
end

assign fan = fan;
assign heater = heater;
assign aircon = aircon;

endmodule
