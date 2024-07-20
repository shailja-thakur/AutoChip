module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  reg fan;
  
  // Control the fan
  always @* begin
    if (fan_on == 1 || too_cold == 1 || too_hot == 1)
      fan = 1;
    else
      fan = 0;
  end
  
  // Control the heater
  assign heater = (mode == 1) && (too_cold == 1);
  
  // Control the air conditioner
  assign aircon = (mode == 0) && (too_hot == 1);
  
endmodule
