module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  // Internal signal declarations
  wire turn_on_heater;
  wire turn_on_aircon;

  // Logic for turning on the heater based on mode and temperature
  assign turn_on_heater = (mode == 1) && too_cold;
  assign heater = turn_on_heater;

  // Logic for turning on the air conditioner based on mode and temperature
  assign turn_on_aircon = (mode == 0) && too_hot;
  assign aircon = turn_on_aircon;

  // Logic for turning on the fan based on mode, temperature, and fan request
  assign fan = (turn_on_heater || turn_on_aircon || fan_on);
endmodule
