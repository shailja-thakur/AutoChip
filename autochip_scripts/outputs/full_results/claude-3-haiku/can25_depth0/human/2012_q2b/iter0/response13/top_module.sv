module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

assign Y1 = (y[0] & ~w) | (y[1] & w) | (y[3] & ~w); // A -> A, B -> C, D -> A
assign Y3 = (y[1] & ~w) | (y[2] & w) | (y[3] & w) | (y[5] & w); // B -> D, C -> D, D -> F, F -> C

endmodule
