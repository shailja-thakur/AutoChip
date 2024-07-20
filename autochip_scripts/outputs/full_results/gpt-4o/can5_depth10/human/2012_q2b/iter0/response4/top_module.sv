module top_module (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

  assign Y1 = (y[0] & w) | (y[1] & ~w) | (y[5] & w); // Transition to state B: (A to B) or (B to D) or (F to C)
  assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w) | (y[5] & ~w); // Transition to state D: (B to D) or (C to D) or (E to D) or (F to D)

endmodule
