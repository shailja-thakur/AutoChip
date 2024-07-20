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
  wire activate_heater;
  wire activate_aircon;
  wire activate_fan;

  // Logic to control heater, aircon, and fan activation based on mode and temperature conditions
  assign activate_heater = (mode == 1) && (too_cold == 1);
  assign activate_aircon = (mode == 0) && (too_hot == 1);
  assign activate_fan = (fan_on == 1) || (activate_heater == 1) || (activate_aircon == 1);

  // Connect outputs to internal signals
  assign heater = activate_heater;
  assign aircon = activate_aircon;
  assign fan = activate_fan;

endmodule
