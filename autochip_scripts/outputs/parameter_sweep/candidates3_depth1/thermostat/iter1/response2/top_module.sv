module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output reg heater,
  output reg aircon,
  output reg fan
);

  // Declare internal signals
  reg turn_on_heater;
  reg turn_on_aircon;

  // Check conditions to turn on heater
  always @(mode or too_cold or fan_on) begin
    if (mode == 1 && too_cold == 1)
      turn_on_heater = 1;
    else
      turn_on_heater = fan_on;
  end
  
  // Check conditions to turn on aircon
  always @(mode or too_hot or fan_on) begin
    if (mode == 0 && too_hot == 1)
      turn_on_aircon = 1;
    else
      turn_on_aircon = fan_on;
  end

  // Assign outputs
  always @(turn_on_heater or fan_on) begin
    heater = turn_on_heater;
    fan = turn_on_heater;
  end

  always @(turn_on_aircon or fan_on) begin
    aircon = turn_on_aircon;
    fan = turn_on_aircon;
  end

endmodule
