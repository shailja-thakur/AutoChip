module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  reg heater;
  reg aircon;
  reg fan;

  always @(*)
  begin
    if (mode == 1) // heating mode
    begin
      if (too_cold == 1)
      begin
        heater = 1;
        aircon = 0;
        fan = 1;
      end
      else if (fan_on == 1)
      begin
        heater = 0;
        aircon = 0;
        fan = 1;
      end
      else
      begin
        heater = 0;
        aircon = 0;
        fan = 0;
      end
    end
    else if (mode == 0) // cooling mode
    begin
      if (too_hot == 1)
      begin
        heater = 0;
        aircon = 1;
        fan = 1;
      end
      else if (fan_on == 1)
      begin
        heater = 0;
        aircon = 0;
        fan = 1;
      end
      else
      begin
        heater = 0;
        aircon = 0;
        fan = 0;
      end
    end
    else // invalid mode
    begin
      heater = 0;
      aircon = 0;
      fan = 0;
    end
  end

  assign heater = heater;
  assign aircon = aircon;
  assign fan = fan;

endmodule
