module top_module (
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  wire fan_controlled;
  wire fan_on_controlled;
  wire heater_controlled;
  wire aircon_controlled;

  assign fan_controlled = too_cold || too_hot || fan_on;
  assign fan_on_controlled = fan_on;
  assign heater_controlled = mode && too_cold;
  assign aircon_controlled = ~mode && too_hot;

  assign heater = heater_controlled;
  assign aircon = aircon_controlled;
  assign fan = fan_controlled;

endmodule
