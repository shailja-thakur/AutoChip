module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State assignments using one-hot encoding
    wire A = y[0];
    wire B = y[1];
    wire C = y[2];
    wire D = y[3];
    wire E = y[4];
    wire F = y[5];

    // Deriving Y1 (the input for state B)
    // Y1 = A & w   (from A to B) 
    assign Y1 = A & w;

    // Deriving Y3 (the input for state D)
    // Y3 = B & ~w | C & ~w | D & ~w | E & ~w | F & ~w
    assign Y3 = (B & ~w) | (C & ~w) | (D & ~w) | (E & ~w) | (F & ~w);

endmodule
