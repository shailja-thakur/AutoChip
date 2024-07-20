module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

  wire fan_on_internal;
  
  assign fan_on_internal = (fan_on || (heater || aircon));
  
  assign heater = (mode && too_cold && !too_hot) ? 1 : 0;
  assign aircon = (!mode && too_hot && !too_cold) ? 1 : 0;
  assign fan = fan_on_internal;
  
endmodule
