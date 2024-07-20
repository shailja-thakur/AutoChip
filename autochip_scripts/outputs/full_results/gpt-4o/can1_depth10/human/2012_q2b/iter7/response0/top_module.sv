module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // One-hot state encoding for reference
    // y[5:0] = 000001 -> A
    // y[5:0] = 000010 -> B
    // y[5:0] = 000100 -> C
    // y[5:0] = 001000 -> D
    // y[5:0] = 010000 -> E
    // y[5:0] = 100000 -> F

    // Logic for Y1 (input of state flip-flop y[1])
    // Y1 is high when transitioning to state B
    // A(000001) -> B(000010) on input w=1
    assign Y1 = y[0] & w;

    // Logic for Y3 (input of state flip-flop y[3])
    // Y3 is high when transitioning to state D
    // B -> D on input w=0
    // C -> D on input w=0
    // F -> D on input w=0
    // A -> A on input w=0 (loop-back in A)
    assign Y3 = (y[1] & ~w) | // B -> D on input w=0
                (y[2] & ~w) | // C -> D on input w=0
                (y[3] & ~w) | // D -> D on input w=0 (loop-back in D)
                (y[5] & ~w);  // F -> D on input w=0

endmodule
