module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Derive the logic equations for Y2 and Y4 by inspection

// Y2 corresponds to state y[2]
// Y2 = y[2]' & (y[1] & ~w) // B to C
      | y[2] & (y[1] & w)  // B to D

assign Y2 = (y[2] & ~y[1] & ~w) | (y[2] & y[1] & w);

// Y4 corresponds to state y[4]
// Y4 = y[4]' & (y[3] & ~w) // C to E
      | y[4] & (y[3] & w)  // C to D
      | y[4] & y[6] & ~w   // F to C

assign Y4 = (y[4] & ~y[3] & ~w) | (y[4] & y[3] & w) | (y[4] & y[6] & ~w);

endmodule
