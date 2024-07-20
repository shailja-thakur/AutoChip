module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output reg fan
);

  reg fan_temp;

  assign fan = fan_temp;

  always @(mode, too_cold, too_hot, fan_on)
  begin
    if (fan_on == 1'b1 || too_cold == 1'b1 || too_hot == 1'b1)
      fan_temp = 1'b1;
    else
      fan_temp = 1'b0;

    if (mode == 1'b1 && too_cold == 1'b1)
      heater = 1'b1;
    else
      heater = 1'b0;

    if (mode == 1'b0 && too_hot == 1'b1)
      aircon = 1'b1;
    else
      aircon = 1'b0;
  end

endmodule
