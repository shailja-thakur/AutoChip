module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Calculate Y2 (state B)
    // Y2 is being calculated from the following transitions:
    // A (y[1]) --0--> B (y[2])
    assign Y2 = y[1] & ~w;

    // Calculate Y4 (state D)
    // Y4 is being calculated from the following transitions:
    // B (y[2]) --1--> D (y[4])
    // C (y[3]) --1--> D (y[4])
    // E (y[5]) --1--> D (y[4])
    // F (y[6]) --1--> D (y[4])
    assign Y4 = (y[2] | y[3] | y[5] | y[6]) & w;

endmodule
