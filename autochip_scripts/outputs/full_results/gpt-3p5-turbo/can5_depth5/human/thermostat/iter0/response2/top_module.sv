module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
  );
  
  wire heater_on;
  wire aircon_on;
  wire fan_on_internal;

  assign heater = heater_on;
  assign aircon = aircon_on;
  assign fan = fan_on_internal;

  // Turn on the heater when it is too cold in heating mode
  // Turn on the air conditioner when it is too hot in cooling mode
  always @(mode, too_cold, too_hot) begin
    if (mode == 1 && too_cold)
      heater_on = 1;
    else if (mode == 0 && too_hot)
      aircon_on = 1;
    else
      begin
        heater_on = 0;
        aircon_on = 0;
      end
  end

  // Turn on the fan when either the heater or air conditioner is on, or when the fan is requested
  always @(heater_on, aircon_on, fan_on) begin
    if (heater_on || aircon_on || fan_on)
      fan_on_internal = 1;
    else
      fan_on_internal = 0;
  end

endmodule
