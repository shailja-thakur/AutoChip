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
  
  // Assign the fan control signal based on conditions
  assign fan_ctrl = (mode && too_cold) || (!mode && too_hot) || fan_on;
  
  // Assign outputs based on mode and fan control
  assign heater = (mode && too_cold) ? 1'b1 : 1'b0;
  assign aircon = (!mode && too_hot) ? 1'b1 : 1'b0;
  assign fan = fan_ctrl;
  
endmodule
