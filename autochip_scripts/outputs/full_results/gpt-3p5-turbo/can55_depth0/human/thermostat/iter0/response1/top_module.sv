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
  wire heater_on; // Signal to control the heater
  wire aircon_on; // Signal to control the air conditioner

  // Control signals for the fan
  assign fan = fan_on | heater_on | aircon_on;

  // Control signal for the heater
  assign heater = (mode == 1) & too_cold;

  // Control signal for the air conditioner
  assign aircon = (mode == 0) & too_hot;

endmodule
