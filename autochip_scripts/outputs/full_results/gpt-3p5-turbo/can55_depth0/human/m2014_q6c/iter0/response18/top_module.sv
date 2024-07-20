module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire A, B, C, D, E, F;
    wire Y2_int, Y4_int;

    assign A = y[1];
    assign B = y[2];
    assign C = y[3];
    assign D = y[4];
    assign E = y[5];
    assign F = y[6];

    // Next-state logic for Y2
    assign Y2_int = (~B & ~D & ~E & ~F) | (A & B & w & ~E) | (C & ~E & ~F) | (D & ~w);

    // Next-state logic for Y4
    assign Y4_int = (~D & ~E) | (B & D & ~w) | (C & ~w & ~F) | (E & w & ~C);

    // Output logic
    assign Y2 = Y2_int;
    assign Y4 = Y4_int;
    
endmodule
