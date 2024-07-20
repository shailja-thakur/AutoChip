module top_module(
	input mode,
	input too_cold, 
	input too_hot,
	input fan_on,
	output heater,
	output aircon,
	output fan
);
  
  reg fan_internal;
  
  // Logic for determining when to turn on the heater
  always @(mode or too_cold or fan_on) begin
    if (mode == 1 && too_cold == 1)
      heater = 1;
    else
      heater = 0;
  end
  
  // Logic for determining when to turn on the air conditioner
  always @(mode or too_hot or fan_on) begin
    if (mode == 0 && too_hot == 1)
      aircon = 1;
    else
      aircon = 0;
  end
  
  // Logic for determining when to turn on the fan
  always @(heater or aircon or fan_on) begin
    if (heater == 1 || aircon == 1 || fan_on == 1)
      fan_internal = 1;
    else
      fan_internal = 0;
  end
  
  // Assigning the fan output to the internal fan signal
  assign fan = fan_internal;
  
endmodule
