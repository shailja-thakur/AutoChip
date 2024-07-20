module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  always @* begin
    if (mode == 1) begin  // heating mode
      heater = (too_cold == 1) ? 1 : 0;
      aircon = 0;
      fan = (heater == 1 || fan_on == 1) ? 1 : 0;
    end else begin       // cooling mode
      heater = 0;
      aircon = (too_hot == 1) ? 1 : 0;
      fan = (aircon == 1 || fan_on == 1) ? 1 : 0;
    end
  end

endmodule
