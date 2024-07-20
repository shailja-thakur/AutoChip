module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Extract state bits for readability
    wire A = y[1];
    wire B = y[2];
    wire C = y[3];
    wire D = y[4];
    wire E = y[5];
    wire F = y[6];

    // Calculate next state signals Y2 and Y4
    // Y2 corresponds to state B
    assign Y2 = (A & ~w) | (E & ~w) | (F & ~w);

    // Y4 corresponds to state D
    assign Y4 = (B & w) | (C & w) | (D & w) | (E & w) | (F & w);

endmodule
