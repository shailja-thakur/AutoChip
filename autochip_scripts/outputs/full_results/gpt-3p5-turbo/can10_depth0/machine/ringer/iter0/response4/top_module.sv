module top_module(
  input wire ring,
  input wire vibrate_mode,
  output wire ringer,
  output wire motor
);

// Control the ringer output
assign ringer = ring & ~vibrate_mode;

// Control the motor output
assign motor = ring & vibrate_mode;

endmodule
