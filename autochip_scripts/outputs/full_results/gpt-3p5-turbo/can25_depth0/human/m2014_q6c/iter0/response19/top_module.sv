module top_module (
  input [6:1] y,
  input w,
  output Y2,
  output Y4
);

  wire A; // state A
  wire B; // state B
  wire C; // state C
  wire D; // state D
  wire E; // state E
  wire F; // state F

  assign A = y[6];
  assign B = y[5];
  assign C = y[4];
  assign D = y[3];
  assign E = y[2];
  assign F = y[1];

  // Next state logic for Y2
  assign Y2 = ~w & (B | D | E);

  // Next state logic for Y4
  assign Y4 = ~w & (C | F);

endmodule
