module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

  reg fan_on_internal;

  always @(mode or too_cold or too_hot or fan_on)
  begin
    if (mode == 1 && too_cold == 1)
    begin
      heater = 1;
      aircon = 0;
      fan_on_internal = 1;
    end
    else if (mode == 0 && too_hot == 1)
    begin
      heater = 0;
      aircon = 1;
      fan_on_internal = 1;
    end
    else if (fan_on == 1)
    begin
      heater = 0;
      aircon = 0;
      fan_on_internal = 1;
    end
    else
    begin
      heater = 0;
      aircon = 0;
      fan_on_internal = 0;
    end
  end

  assign fan = fan_on_internal;

endmodule
