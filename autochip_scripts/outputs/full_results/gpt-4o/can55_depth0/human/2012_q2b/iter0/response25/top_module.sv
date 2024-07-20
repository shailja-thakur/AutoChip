module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

    // Definitions of states in one-hot encoding
    // y[5:0] = 000001(A), 000010(B), 000100(C), 001000(D), 010000(E), 100000(F)
    wire A = y[0];
    wire B = y[1];
    wire C = y[2];
    wire D = y[3];
    wire E = y[4];
    wire F = y[5];

    // Logic for Y1 and Y3 based on state transitions
    assign Y1 = (A & w) | (B & ~w);
    assign Y3 = (B & ~w) | (C & ~w) | (D & ~w) | (E & ~w) | (F & ~w);

endmodule
