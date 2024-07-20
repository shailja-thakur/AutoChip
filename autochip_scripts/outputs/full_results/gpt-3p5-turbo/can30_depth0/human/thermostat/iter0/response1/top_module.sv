module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output reg heater,
  output reg aircon,
  output reg fan
);

  always @(*)
  begin
    heater = 0;
    aircon = 0;
    fan = 0;

    if (mode == 1) // heating mode
    begin
      if (too_cold == 1)
      begin
        heater = 1;
        fan = 1;
      end
      else if (fan_on == 1)
      begin
        fan = 1;
      end
    end

    else // cooling mode
    begin
      if (too_hot == 1)
      begin
        aircon = 1;
        fan = 1;
      end
      else if (fan_on == 1)
      begin
        fan = 1;
      end
    end
  end
  
endmodule
