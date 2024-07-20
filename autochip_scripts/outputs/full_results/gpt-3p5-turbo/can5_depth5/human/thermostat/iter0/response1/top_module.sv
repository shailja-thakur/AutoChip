module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

	assign heater = (mode == 1 && too_cold) || (mode == 0 && fan_on);
	assign aircon = (mode == 0 && too_hot) || (mode == 1 && fan_on);
	assign fan = heater || aircon || fan_on;
  
endmodule
