module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output reg heater,
  output reg aircon,
  output reg fan
);

  always @(mode or too_cold or too_hot or fan_on)
  begin
    heater = 0;
    aircon = 0;
    fan = 0;
    
    if (mode == 1) // heating mode
    begin
      if (too_cold == 1)
        heater = 1;
      
      if (fan_on == 1)
        fan = 1;
    end
    else // cooling mode
    begin
      if (too_hot == 1)
        aircon = 1;
        
      if (fan_on == 1)
        fan = 1;
    end
  end
endmodule
