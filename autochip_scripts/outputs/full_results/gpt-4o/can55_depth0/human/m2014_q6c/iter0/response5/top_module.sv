module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // State encoding:
    // A: 000001
    // B: 000010
    // C: 000100
    // D: 001000
    // E: 010000
    // F: 100000

    // Y2 corresponds to the next state being B (000010)
    // B (000010) -> next state is C (000100) if w == 0, D (001000) if w == 1
    // Y4 corresponds to the next state being D (001000)
    // D (001000) -> next state is F (100000) if w == 0, A (000001) if w == 1

    assign Y2 = (y[1] & ~w) | (y[2] & ~w);
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & ~w);
endmodule
