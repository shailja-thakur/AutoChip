module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Derivation of Y1
assign Y1 = (~y[0] & y[1]) | (y[1] & ~y[3] & ~y[4] & ~y[5]) | (y[3] & y[5] & ~w);

// Derivation of Y3
assign Y3 = (~y[0] & ~y[1] & y[3]) | (y[1] & y[3] & ~y[4] & ~y[5]) | (y[3] & ~y[5] & w) | (y[4] & y[5] & ~w);

endmodule
