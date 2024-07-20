module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // One-hot state encoding
    wire A = y[1];
    wire B = y[2];
    wire C = y[3];
    wire D = y[4];
    wire E = y[5];
    wire F = y[6];

    // Next-state logic
    assign Y2 = (A & ~w) | (B & ~w); // Next state B (y[2]) occurs if currently in state A or B with w = 0
    assign Y4 = (B & w) | (C & w) | (D & ~w) | (E & w) | (F & w); // Next state D (y[4]) occurs for various transitions as per given diagram

endmodule
