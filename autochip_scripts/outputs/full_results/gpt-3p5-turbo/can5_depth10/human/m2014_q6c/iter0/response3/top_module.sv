module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

  // Declare internal signals
  wire A, B, C, D, E, F;

  // Assign next-state logic
  assign A = (~y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1] & ~y[0] & ~w) | (y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1] & ~y[0] & w);
  assign B = (~y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1] & w & ~y[0]) | (y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1] & w & y[0]);
  assign C = (~y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] & w & ~y[1] & ~y[0]) | (y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] & w & y[1] & y[0]);
  assign D = (~y[6] & ~y[5] & ~y[4] & ~y[3] & w & ~y[2] & ~y[1] & ~y[0]) | (y[6] & ~y[5] & ~y[4] & ~y[3] & w & ~y[2] & y[1] & y[0]);
  assign E = (~y[6] & ~y[5] & ~y[4] & w & ~y[3] & ~y[2] & ~y[1] & ~y[0]) | (y[6] & ~y[5] & ~y[4] & w & y[3] & y[2] & y[1] & y[0]);
  assign F = (~y[6] & ~y[5] & w & ~y[4] & ~y[3] & ~y[2] & ~y[1] & ~y[0]) | (y[6] & ~y[5] & w & y[4] & y[3] & y[2] & ~y[1] & ~y[0]);

  // Assign outputs
  assign Y2 = B;
  assign Y4 = D;

endmodule
