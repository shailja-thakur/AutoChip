module top_module(
  input ring,
  input vibrate_mode,
  output ringer,
  output motor
);

  // assign statement for ringer
  assign ringer = ring & ~vibrate_mode;

  // assign statement for motor
  assign motor = ring & vibrate_mode;

endmodule
