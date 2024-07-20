module top_module(
  input mode,
  input too_cold, 
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  // Internal signals
  wire fan_ctrl;
  
  // Assignments
  assign heater = (mode == 1) && (too_cold || fan_on);
  assign aircon = (mode == 0) && (too_hot || fan_on);
  assign fan_ctrl = heater || aircon || fan_on;
  assign fan = fan_ctrl;
  
endmodule
