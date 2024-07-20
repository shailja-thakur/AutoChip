module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Y1 is the input of state flip-flop y[1], which corresponds to state B
    // The transitions to state B are:
    // A --1--> B: y[0] & w
    assign Y1 = y[0] & w;

    // Y3 is the input of state flip-flop y[3], which corresponds to state D
    // The transitions to state D are:
    // B --0--> D: y[1] & ~w
    // C --0--> D: y[2] & ~w
    // E --0--> D: y[4] & ~w
    // F --0--> D: y[5] & ~w
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
