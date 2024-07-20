module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // y[5:0] = 000001(A), 000010(B), 000100(C), 001000(D), 010000(E), 100000(F)
    // One-hot encoding:
    // y[0] -> A
    // y[1] -> B
    // y[2] -> C
    // y[3] -> D
    // y[4] -> E
    // y[5] -> F

    // Define the boolean expressions for Y1 and Y3 based on state transitions:
    // Y1 (next state B): B is entered from A on input w (y[0] & w)
    assign Y1 = (y[0] & w);

    // Y3 (next state D): D is entered from B on input !w (y[1] & ~w) or from C on !w (y[2] & ~w) or from D on !w (y[3] & ~w) or from E on !w (y[4] & ~w) or from F on !w (y[5] & ~w)
    assign Y3 = (y[1] & ~w) | (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[5] & ~w);

endmodule
