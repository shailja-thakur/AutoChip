module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State A (000001)
    assign Y2 = ~y[6] & ~y[1] & ~w;
    assign Y4 = ~y[6] & ~y[5] & ~w;

    // State B (000010)
    assign Y2 = y[6] & ~y[1] & ~w;
    assign Y4 = ~y[6] & ~y[5] & w;

    // State C (000100)
    assign Y2 = ~y[6] & ~y[1] & w;
    assign Y4 = ~y[6] & ~y[5] & w;

    // State D (001000)
    assign Y2 = ~y[6] & y[1] & ~w;
    assign Y4 = ~y[6] & ~y[5] & w;

    // State E (010000)
    assign Y2 = ~y[6] & ~y[1] & ~w;
    assign Y4 = y[6] & ~y[5] & ~w;

    // State F (100000)
    assign Y2 = ~y[6] & ~y[1] & ~w;
    assign Y4 = y[6] & ~y[5] & w;

endmodule
