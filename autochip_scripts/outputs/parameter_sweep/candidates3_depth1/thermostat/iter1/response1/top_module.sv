module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  // Declare internal signals
  wire turn_on_heater;
  wire turn_on_aircon;

  // Check conditions to turn on heater
  assign turn_on_heater = (mode == 1) && (too_cold == 1);

  // Check conditions to turn on aircon
  assign turn_on_aircon = (mode == 0) && (too_hot == 1);

  always @(*) begin
    // Assign heater output
    if (turn_on_heater || fan_on)
      heater = 1;
    else
      heater = 0;
  
    // Assign aircon output
    if (turn_on_aircon || fan_on)
      aircon = 1;
    else
      aircon = 0;
  
    // Assign fan output
    fan = heater || aircon || fan_on;
  end

endmodule
