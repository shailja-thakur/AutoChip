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

  assign fan = (fan_on || too_cold || too_hot);

  always @(mode, too_cold)
  begin
    if (mode && too_cold)
      heater = 1;
    else
      heater = 0;
  end

  always @(mode, too_hot)
  begin
    if (!mode && too_hot)
      aircon = 1;
    else
      aircon = 0;
  end

endmodule
