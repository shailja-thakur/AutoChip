module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output reg heater,
  output reg aircon,
  output reg fan
);

  always @*
  begin
    // In heating mode, turn the heater on when it is too cold
    if (mode == 1 && too_cold)
    begin
      heater = 1;
      aircon = 0;
      fan = 1;
    end
    // In cooling mode, turn the air conditioner on when it is too hot
    else if (mode == 0 && too_hot)
    begin
      heater = 0;
      aircon = 1;
      fan = 1;
    end
    // When the heater or air conditioner are on, also turn on the fan
    else if (heater || aircon)
    begin
      fan = 1;
    end
    // User can request the fan to turn on, even if the heater and air conditioner are off
    else if (fan_on)
    begin
      fan = 1;
    end
    // Turn off all devices if none of the conditions are met
    else
    begin
      heater = 0;
      aircon = 0;
      fan = 0;
    end
  end
  
endmodule
