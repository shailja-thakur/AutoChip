module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  // Control logic for heater
  assign heater = (mode == 1) && too_cold;

  // Control logic for air conditioner
  assign aircon = (mode == 0) && too_hot;

  // Control logic for fan
  assign fan = heater || aircon || fan_on;

endmodule
