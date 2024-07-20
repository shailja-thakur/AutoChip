module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // Assign Y1 (input of flip-flop y[1])
    // y[1] corresponds to state B: Transitions to state C on w=1 and state D on w=0
    assign Y1 = y[0] & w;

    // Assign Y3 (input of flip-flop y[3])
    // y[3] corresponds to state D: Transitions to state F on w=1 and state A on w=0
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[4] & ~w);

endmodule
