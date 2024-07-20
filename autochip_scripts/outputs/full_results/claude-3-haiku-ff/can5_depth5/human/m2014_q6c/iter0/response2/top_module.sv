module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

// Next-state logic for y[2]
assign Y2 = (y[1] & ~w) |  // A -> B
           (y[3] & ~w) |  // B -> C
           (y[5] & w);    // E -> D

// Next-state logic for y[4]
assign Y4 = (y[2] & ~w) |  // B -> D
           (y[3] & w) |    // B -> D
           (y[5] & ~w) |   // E -> E
           (y[6] & w);     // F -> D

endmodule
