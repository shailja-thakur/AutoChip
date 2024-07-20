module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // One-hot encoding for states
    // y[0] = A, y[1] = B, y[2] = C, y[3] = D, y[4] = E, y[5] = F
    
    assign Y1 = (y[0] & w); // Y1: B is next if in state A and w is 1
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w); // Y3: D is next if in state B, C, E, or F and w is 0 (A -> D by default for states that lead to D on 0)

endmodule
