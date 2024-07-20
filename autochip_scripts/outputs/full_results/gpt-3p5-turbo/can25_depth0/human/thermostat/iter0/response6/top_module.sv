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

  always @(*) begin
    if (mode == 1) begin
      // Heating mode
      heater = too_cold;
      aircon = 0;
    end else begin
      // Cooling mode
      heater = 0;
      aircon = too_hot;
    end

    if (heater || aircon || fan_on)
      fan = 1;
    else
      fan = 0;
  end
endmodule
