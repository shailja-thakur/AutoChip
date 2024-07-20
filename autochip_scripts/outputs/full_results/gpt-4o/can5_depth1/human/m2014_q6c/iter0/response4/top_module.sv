module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // A: 000001
    // B: 000010
    // C: 000100
    // D: 001000
    // E: 010000
    // F: 100000

    // Y2 is '1' for state C only
    assign Y2 = (y[2] & ~w) | 
                (y[1] & w);

    // Y4 is '1' for state E only
    assign Y4 = (y[3] & ~w) | 
                (y[5] & w);

endmodule
