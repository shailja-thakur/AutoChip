module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output reg heater,
  output reg aircon,
  output reg fan
);

  always @* begin
    if (fan_on || too_cold || too_hot)  // Check if any of the conditions for the fan to be on are met
      fan = 1'b1;  // Turn on the fan
    else
      fan = 1'b0;  // Turn off the fan

    if (mode && too_cold)  // Check if the mode is heating and the room is too cold
      heater = 1'b1;  // Turn on the heater
    else
      heater = 1'b0;  // Turn off the heater

    if (!mode && too_hot)  // Check if the mode is cooling and the room is too hot
      aircon = 1'b1;  // Turn on the air conditioner
    else
      aircon = 1'b0;  // Turn off the air conditioner
  end

endmodule
