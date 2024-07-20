module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  // Intermediate signals
  wire fan_on_cond;
  wire heater_on_cond;
  wire aircon_on_cond;

  // Conditions for turning on the fan, heater and aircon
  assign fan_on_cond = fan_on | (heater_on_cond ? 1'b1 : 1'b0);
  assign heater_on_cond = (mode == 1'b1) & too_cold;
  assign aircon_on_cond = (mode == 1'b0) & too_hot;

  // Fan, heater and aircon outputs
  assign heater = heater_on_cond ? 1'b1 : 1'b0;
  assign aircon = aircon_on_cond ? 1'b1 : 1'b0;
  assign fan = fan_on_cond ? 1'b1 : 1'b0;

endmodule
