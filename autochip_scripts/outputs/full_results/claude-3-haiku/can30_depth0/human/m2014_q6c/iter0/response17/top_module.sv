module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

wire A, B, C, D, E, F;
assign {A, B, C, D, E, F} = y;

// Derive the logic equations for Y2 and Y4
assign Y2 = (B & ~w) | (C & ~w) | (E & w);
assign Y4 = (B & ~w) | (D & ~w) | (D & w) | (F & w);

endmodule
