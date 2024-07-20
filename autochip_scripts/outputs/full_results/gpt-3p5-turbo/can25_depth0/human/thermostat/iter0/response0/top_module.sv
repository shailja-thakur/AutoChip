module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);
  
  // Declare internal wires
  wire fan_on_internal;
  wire heater_internal;
  wire aircon_internal;
  
  // Fan control logic
  assign fan = (fan_on == 1) | (fan_on_internal == 1);
  
  // Heating mode control logic
  assign heater = (mode == 1) & (too_cold == 1) & (fan == 1);
  
  // Cooling mode control logic
  assign aircon = (mode == 0) & (too_hot == 1) & (fan == 1);
  
  // Internal fan control logic
  assign fan_on_internal = (heater == 1) | (aircon == 1) | (fan_on == 1);
  
endmodule
