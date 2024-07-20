module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    assign Y1 = (y[0] & w) | (y[1] & ~w);         // y[1] is state B: 1 from A on w=1, 0 from B on w=0
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[5] & ~w); // y[3] is state D: 0 from B, C, F
    
endmodule
