module top_module(
  input mode,
  input too_cold, 
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  // Define wire signals
  wire fan_ctrl;
  wire heater_ctrl;
  wire aircon_ctrl;

  // Turn on fan if too_cold, too_hot, or fan_on is high
  assign fan_ctrl = (too_cold || too_hot || fan_on) ? 1'b1 : 1'b0;

  // Turn on heater if mode is high and too_cold is high
  assign heater_ctrl = (mode && too_cold) ? 1'b1 : 1'b0;

  // Turn on aircon if mode is low and too_hot is high
  assign aircon_ctrl = (mode && !too_cold && too_hot) ? 1'b1 : 1'b0;

  // Assign outputs
  assign heater = heater_ctrl;
  assign aircon = aircon_ctrl;
  assign fan = fan_ctrl;

endmodule
