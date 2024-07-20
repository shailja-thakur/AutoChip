module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  reg fan_on_internal;

  always @(mode or too_cold or too_hot or fan_on) begin
    fan_on_internal = fan_on;
    
    if (mode) begin // Heating mode
      heater = too_cold;
      aircon = 0;
      fan = too_cold || fan_on_internal;
    end else begin // Cooling mode
      heater = 0;
      aircon = too_hot;
      fan = too_hot || fan_on_internal;
    end
  end

endmodule
