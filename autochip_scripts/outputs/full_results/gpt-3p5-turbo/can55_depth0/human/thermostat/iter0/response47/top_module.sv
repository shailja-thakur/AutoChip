module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  // Declare internal signals
  wire fan_control;

  // Heater control logic
  assign heater = (mode & too_cold) | (fan_on & ~mode);

  // Air conditioner control logic
  assign aircon = (~mode & too_hot) | (fan_on & mode);

  // Fan control logic
  assign fan = fan_on | heater | aircon;

endmodule
