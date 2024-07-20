module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // y[1]: A
    // y[2]: B
    // y[3]: C
    // y[4]: D
    // y[5]: E
    // y[6]: F

    // Next state Y2 logic (State B):
    // Y2 should be 1 when:
    // - current state is A (y[1]) and w is 0
    assign Y2 = (y[1] & ~w);

    // Next state Y4 logic (State D):
    // Y4 should be 1 when:
    // - current state is B (y[2]) and w is 1
    // - current state is C (y[3]) and w is 1
    // - current state is D (y[4]) and w is 1
    // - current state is E (y[5]) and w is 1
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w);

endmodule
