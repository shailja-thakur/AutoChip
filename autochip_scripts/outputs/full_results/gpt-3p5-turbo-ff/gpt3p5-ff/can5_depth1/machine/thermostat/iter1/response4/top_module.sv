module top_module(
  input mode,
  input too_cold,
  input too_hot,
  input fan_on,
  output heater,
  output aircon,
  output fan
);

  assign fan = (fan_on || too_cold || too_hot) ? 1'b1 : 1'b0;
  assign heater = (mode && too_cold) ? 1'b1 : 1'b0;
  assign aircon = (~mode && too_hot) ? 1'b1 : 1'b0;

endmodule
