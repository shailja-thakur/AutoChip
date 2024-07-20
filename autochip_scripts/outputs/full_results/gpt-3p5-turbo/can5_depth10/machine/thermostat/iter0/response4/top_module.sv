module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);

  reg fan, heater, aircon;
  
  // Fan control
  always @(*)
  begin
    if (too_cold || too_hot || fan_on)
      fan = 1;
    else
      fan = 0;
  end
  
  // Heater control
  always @(*)
  begin
    if (mode && too_cold)
      heater = 1;
    else
      heater = 0;
  end
  
  // Air conditioner control
  always @(*)
  begin
    if (!mode && too_hot)
      aircon = 1;
    else
      aircon = 0;
  end

endmodule
