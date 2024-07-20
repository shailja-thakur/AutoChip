module top_module(
  input wire ring,
  input wire vibrate_mode,
  output wire ringer,
  output wire motor
);

  // assign the ringer output based on the ring and vibrate_mode inputs
  assign ringer = ring & ~vibrate_mode;

  // assign the motor output based on the ring and vibrate_mode inputs
  assign motor = ring & vibrate_mode;

endmodule
