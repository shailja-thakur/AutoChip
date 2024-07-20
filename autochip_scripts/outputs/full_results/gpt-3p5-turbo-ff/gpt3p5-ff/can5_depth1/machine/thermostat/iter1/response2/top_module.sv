module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output reg heater,
  output reg aircon,
  output reg fan
);

  always @(mode, too_cold, too_hot, fan_on)
  begin
    fan = (fan_on || too_cold || too_hot) ? 1'b1 : 1'b0;
    heater = (mode && too_cold) ? 1'b1 : 1'b0;
    aircon = (~mode && too_hot) ? 1'b1 : 1'b0;
  end

endmodule
