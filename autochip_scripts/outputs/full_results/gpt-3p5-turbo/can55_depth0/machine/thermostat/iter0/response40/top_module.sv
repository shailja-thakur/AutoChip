module top_module(
    input mode,
    input too_cold,
    input too_hot,
    input fan_on,
    output heater,
    output aircon,
    output fan
);

  // Outputs
  assign heater = (mode & too_cold);
  assign aircon = (~mode & too_hot);
  assign fan = (fan_on | too_cold | too_hot);

endmodule
