module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  reg heater, aircon, fan;

  always @(*) begin
    // Turn on heater if mode is heating and it is too cold
    if (mode && too_cold)
      heater = 1;
    else
      heater = 0;
    
    // Turn on air conditioner if mode is cooling and it is too hot
    if (!mode && too_hot)
      aircon = 1;
    else
      aircon = 0;
    
    // Turn on fan if fan_on is requested, or if either heater or air conditioner is on
    if (fan_on || heater || aircon)
      fan = 1;
    else
      fan = 0;
  end

endmodule
