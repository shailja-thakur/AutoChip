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
  
  always @*
  begin
    fan = (fan_on || too_cold || too_hot);
    heater = (mode && too_cold);
    aircon = (!mode && too_hot);
  end

endmodule
