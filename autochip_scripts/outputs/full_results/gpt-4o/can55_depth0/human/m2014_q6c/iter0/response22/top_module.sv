module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // y[6:1] encoding:
    // A = 000001 -> y[1]
    // B = 000010 -> y[2]
    // C = 000100 -> y[3]
    // D = 001000 -> y[4]
    // E = 010000 -> y[5]
    // F = 100000 -> y[6]

    // State transitions for Y2 and Y4:
    // Y2 (next state B):
    // y[1] (A) -- 0 --> y[2] (B)
    // y[3] (C) -- 0 --> y[2] (B)
    // y[2] = (~w & y[1]) | (~w & y[3]);

    // Y4 (next state D):
    // y[2] (B) -- 1 --> y[4] (D)
    // y[3] (C) -- 1 --> y[4] (D)
    // y[6] (F) -- 1 --> y[4] (D)
    // y[4] = (w & (y[2] | y[3] | y[6]));

    assign Y2 = (~w & y[1]) | (~w & y[3]);
    assign Y4 = (w & (y[2] | y[3] | y[6]));

endmodule
