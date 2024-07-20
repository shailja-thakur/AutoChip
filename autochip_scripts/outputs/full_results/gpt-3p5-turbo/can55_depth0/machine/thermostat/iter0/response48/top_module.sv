module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);
  
  // Fan control logic
  assign fan = (fan_on == 1) || (too_cold == 1) || (too_hot == 1);
  
  // Heater control logic
  assign heater = (mode == 1) && (too_cold == 1);
  
  // Air conditioner control logic
  assign aircon = (mode == 0) && (too_hot == 1);
    
endmodule
