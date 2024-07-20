module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
	
	assign heater = fan_on ? 1'b1 : (mode && too_cold);
	assign aircon = fan_on ? 1'b1 : (!mode && too_hot);
	assign fan = heater || aircon || fan_on;

endmodule
