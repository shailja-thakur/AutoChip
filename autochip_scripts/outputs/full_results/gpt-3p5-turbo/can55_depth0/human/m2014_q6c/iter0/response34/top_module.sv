module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Define the internal wire inputs
    wire A, B, C, D, E, F;
  
    // State assignment based on one-hot encoding
    assign A = y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1];
    assign B = ~y[6] & y[5] & ~y[4] & ~y[3] & ~y[2] & ~y[1];
    assign C = ~y[6] & ~y[5] & y[4] & ~y[3] & ~y[2] & ~y[1];
    assign D = ~y[6] & ~y[5] & ~y[4] & y[3] & ~y[2] & ~y[1];
    assign E = ~y[6] & ~y[5] & ~y[4] & ~y[3] & y[2] & ~y[1];
    assign F = ~y[6] & ~y[5] & ~y[4] & ~y[3] & ~y[2] & y[1];

    // Define the logic equations for Y2 and Y4
    assign Y2 = B | D | E;
    assign Y4 = C | F;

endmodule
