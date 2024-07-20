module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  wire turn_on_fan;

  // Logic to determine if fan should be turned on
  assign turn_on_fan = fan_on || (mode == 1 && too_cold) || (mode == 0 && too_hot);

  // Control signals for heater, aircon, and fan
  assign heater = (mode == 1 && too_cold) || fan_on;
  assign aircon = (mode == 0 && too_hot) || fan_on;
  assign fan = turn_on_fan;

endmodule
