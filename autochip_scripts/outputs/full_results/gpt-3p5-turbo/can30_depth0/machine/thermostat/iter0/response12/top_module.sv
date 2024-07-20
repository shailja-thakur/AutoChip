module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  // Fan control
  wire fan_ctrl;
  assign fan_ctrl = (fan_on || too_cold || too_hot);

  // Heater control
  wire heater_ctrl;
  assign heater_ctrl = (mode && too_cold);

  // Air conditioner control
  wire aircon_ctrl;
  assign aircon_ctrl = (!mode && too_hot);

  // Assign outputs
  assign heater = heater_ctrl;
  assign aircon = aircon_ctrl;
  assign fan = fan_ctrl;

endmodule
