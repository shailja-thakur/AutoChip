module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  // Turn on fan if too_cold or too_hot is high, or if fan_on is high
  assign fan = (too_cold || too_hot || fan_on);

  // Turn on heater if mode is high and too_cold is high
  assign heater = (mode && too_cold);

  // Turn on air conditioner if mode is low and too_hot is high
  assign aircon = (!mode && too_hot);

endmodule
