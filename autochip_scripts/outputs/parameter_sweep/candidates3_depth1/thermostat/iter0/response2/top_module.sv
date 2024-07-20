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
  wire turn_on_heater;
  wire turn_on_aircon;

  // Check conditions to turn on heater
  assign turn_on_heater = (mode == 1) && (too_cold == 1);
  
  // Check conditions to turn on aircon
  assign turn_on_aircon = (mode == 0) && (too_hot == 1);

  // Assign heater output
  assign heater = turn_on_heater || fan_on;

  // Assign aircon output
  assign aircon = turn_on_aircon || fan_on;

  // Assign fan output
  assign fan = heater || aircon || fan_on;

endmodule
