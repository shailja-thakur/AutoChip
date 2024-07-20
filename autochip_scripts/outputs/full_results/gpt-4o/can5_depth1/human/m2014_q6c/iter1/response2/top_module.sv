module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // States encoding: 
    // A = 000001, B = 000010, C = 000100, D = 001000, E = 010000, F = 100000
    // y[6:1] represents y6 y5 y4 y3 y2 y1

    // Next-state logic for Y2 (state B)
    // State B (000010) will be active next when:
    // From State A (000001) with w = 0
    assign Y2 = y[1] & ~w;

    // Next-state logic for Y4 (state D)
    // State D (001000) will be active next when:
    // From State B (000010) with w = 1
    // From State C (000100) with w = 1
    // From State D (001000) with w = 0
    // From State E (010000) with w = 0
    // From State F (100000) with w = 1
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & ~w) | (y[5] & ~w) | (y[6] & w);

endmodule
